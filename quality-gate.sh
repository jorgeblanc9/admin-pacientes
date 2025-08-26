#!/bin/bash

# Script de Quality Gate para SonarQube
# Proyecto: Admin-pacientes

set -e  # Salir si cualquier comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Cargar variables de entorno desde .env si existe
if [ -f ".env" ]; then
    print_message "Cargando variables de entorno desde .env..."
    export $(cat .env | grep -v '^#' | xargs)
else
    print_warning "Archivo .env no encontrado. Usando valores por defecto..."
    # Configuración por defecto de SonarQube
    SONAR_PROJECT_KEY="Admin-pacientes"
    SONAR_HOST_URL="https://sonar.webnovawp.com"
    SONAR_TOKEN="sqp_6544e4f4fe74c1a8090d23340361f3f5b2bcebda"
    
    # Exportar variables de entorno para SonarQube
    export SONAR_PROJECT_KEY
    export SONAR_HOST_URL
    export SONAR_TOKEN
fi

print_message "Iniciando análisis de calidad con SonarQube..."
print_message "Proyecto: $SONAR_PROJECT_KEY"
print_message "Host: $SONAR_HOST_URL"

# Verificar si sonar-scanner está instalado
if ! command -v sonar-scanner &> /dev/null; then
    print_error "sonar-scanner no está instalado."
    print_message "Para instalarlo, ejecuta: npm install -g sonarqube-scanner"
    exit 1
fi

# Verificar que estamos en el directorio raíz del proyecto
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi

# Configurar NVM y usar la versión de Node.js especificada en .nvmrc
if [ -f ".nvmrc" ]; then
    print_message "Configurando NVM con versión de .nvmrc..."
    
    # Cargar NVM si está disponible
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        
        # Usar la versión especificada en .nvmrc
        NODE_VERSION=$(cat .nvmrc)
        print_message "Usando Node.js versión: $NODE_VERSION"
        nvm use "$NODE_VERSION"
        
        if [ $? -ne 0 ]; then
            print_warning "No se pudo cambiar a la versión $NODE_VERSION. Intentando instalar..."
            nvm install "$NODE_VERSION"
            nvm use "$NODE_VERSION"
        fi
    else
        print_warning "NVM no está instalado o no está disponible."
        print_message "Asegúrate de tener NVM instalado y la versión correcta de Node.js."
    fi
else
    print_warning "Archivo .nvmrc no encontrado. Usando versión actual de Node.js."
fi

# Verificar versión de Node.js
print_message "Versión de Node.js actual: $(node --version)"
print_message "Versión de npm actual: $(npm --version)"

# Instalar dependencias si es necesario
if [ ! -d "node_modules" ]; then
    print_message "Instalando dependencias..."
    npm install
else
    print_message "Dependencias ya instaladas."
fi

# Generar cobertura de código si no existe
if [ ! -f "coverage/lcov.info" ]; then
    print_message "Generando cobertura de código..."
    npm run test:unit:coverage
else
    print_message "Archivo de cobertura encontrado."
fi

# Verificar si existe sonar-project.properties
if [ ! -f "sonar-project.properties" ]; then
    print_error "Archivo sonar-project.properties no encontrado."
    print_message "Creando archivo sonar-project.properties..."
    cat > sonar-project.properties << EOF
# SonarQube Project Configuration
sonar.projectKey=$SONAR_PROJECT_KEY
sonar.projectName=$SONAR_PROJECT_KEY
sonar.projectVersion=1.0
sonar.sources=src
sonar.tests=src
sonar.language=js
sonar.sourceEncoding=UTF-8
sonar.javascript.lcov.reportPaths=coverage/lcov.info
sonar.coverage.exclusions=**/*.test.js,**/*.spec.js,**/tests/**,**/cypress/**,**/node_modules/**
sonar.test.inclusions=**/*.test.js,**/*.spec.js
sonar.exclusions=**/node_modules/**,**/dist/**,**/coverage/**,**/.git/**,**/cypress/**,**/*.config.js
sonar.qualitygate.wait=true
sonar.verbose=false
EOF
fi

# Ejecutar el análisis de SonarQube
print_message "Ejecutando análisis de código..."

sonar-scanner \
    -Dsonar.host.url="$SONAR_HOST_URL" \
    -Dsonar.login="$SONAR_TOKEN"

if [ $? -eq 0 ]; then
    print_message "✅ Análisis de SonarQube completado exitosamente"
    print_message "📊 Revisa los resultados en: $SONAR_HOST_URL/dashboard?id=$SONAR_PROJECT_KEY"
else
    print_error "❌ El análisis de SonarQube falló"
    exit 1
fi
