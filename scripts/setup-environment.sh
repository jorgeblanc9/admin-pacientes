#!/bin/bash

# Script para configurar el entorno completo
# Proyecto: Admin-pacientes

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

print_message "🚀 Configurando entorno completo para Admin-pacientes..."

# Paso 1: Verificar que estamos en el directorio correcto
print_step "1. Verificando directorio del proyecto..."
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Asegúrate de estar en el directorio raíz del proyecto."
    exit 1
fi
print_message "✅ Directorio del proyecto verificado"

# Paso 2: Configurar NVM
print_step "2. Configurando NVM..."
if [ -f ".nvmrc" ]; then
    NODE_VERSION=$(cat .nvmrc)
    print_message "Versión de Node.js requerida: $NODE_VERSION"
    
    # Cargar NVM
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        
        # Verificar si la versión está instalada
        if nvm list | grep -q "$NODE_VERSION"; then
            print_message "✅ Versión $NODE_VERSION ya está instalada"
        else
            print_message "📦 Instalando Node.js versión $NODE_VERSION..."
            nvm install "$NODE_VERSION"
        fi
        
        # Usar la versión
        nvm use "$NODE_VERSION"
        print_message "✅ Usando Node.js versión: $(node --version)"
    else
        print_error "NVM no está instalado. Por favor instala NVM primero:"
        print_message "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash"
        exit 1
    fi
else
    print_warning "Archivo .nvmrc no encontrado. Usando versión actual de Node.js."
fi

# Paso 3: Instalar dependencias
print_step "3. Instalando dependencias..."
if [ ! -d "node_modules" ]; then
    print_message "📦 Instalando dependencias de npm..."
    npm install
    print_message "✅ Dependencias instaladas"
else
    print_message "✅ Dependencias ya instaladas"
fi

# Paso 4: Configurar variables de entorno
print_step "4. Configurando variables de entorno..."
if [ ! -f ".env" ]; then
    print_message "📝 Creando archivo .env..."
    
    # Solicitar token de SonarQube al usuario
    print_warning "⚠️  IMPORTANTE: Necesitas configurar tu token de SonarQube"
    print_message "📋 Para obtener tu token:"
    print_message "   1. Ve a https://sonar.webnovawp.com"
    print_message "   2. Inicia sesión en tu cuenta"
    print_message "   3. Ve a User > My Account > Security"
    print_message "   4. Genera un nuevo token"
    
    read -p "🔑 Ingresa tu token de SonarQube: " SONAR_TOKEN
    
    if [ -z "$SONAR_TOKEN" ]; then
        print_error "❌ Token no proporcionado. Configuración cancelada."
        print_message "💡 Puedes crear el archivo .env manualmente más tarde."
        exit 1
    fi
    
    # Crear archivo .env con el token proporcionado
    cat > .env << EOF
# SonarQube Configuration
SONAR_PROJECT_KEY=Admin-pacientes
SONAR_HOST_URL=https://sonar.webnovawp.com
SONAR_TOKEN=$SONAR_TOKEN

# SonarQube Analysis Settings
SONAR_SOURCES=.
SONAR_JAVASCRIPT_LCOV_REPORT_PATHS=coverage/lcov.info
SONAR_COVERAGE_EXCLUSIONS=**/*.test.js,**/*.spec.js,**/tests/**,**/cypress/**,**/node_modules/**
SONAR_TEST_INCLUSIONS=**/*.test.js,**/*.spec.js
SONAR_EXCLUSIONS=**/node_modules/**,**/dist/**,**/coverage/**,**/.git/**,**/cypress/**,**/*.config.js
EOF
    print_message "✅ Archivo .env creado con tu token"
    print_message "🔒 El archivo .env está en .gitignore y no se subirá al repositorio"
else
    print_message "✅ Archivo .env ya existe"
fi

# Paso 5: Verificar sonar-scanner
print_step "5. Verificando sonar-scanner..."
if ! command -v sonar-scanner &> /dev/null; then
    print_warning "sonar-scanner no está instalado."
    print_message "📦 Instalando sonar-scanner globalmente..."
    npm install -g sonarqube-scanner
    print_message "✅ sonar-scanner instalado"
else
    print_message "✅ sonar-scanner ya está instalado"
fi

# Paso 6: Generar cobertura inicial
print_step "6. Generando cobertura de código inicial..."
if [ ! -f "coverage/lcov.info" ]; then
    print_message "🧪 Ejecutando pruebas con cobertura..."
    npm run test:unit:coverage
    print_message "✅ Cobertura generada"
else
    print_message "✅ Archivo de cobertura ya existe"
fi

# Paso 7: Verificar configuración final
print_step "7. Verificación final..."
print_message "📊 Información del entorno:"
echo "   - Node.js: $(node --version)"
echo "   - npm: $(npm --version)"
echo "   - sonar-scanner: $(sonar-scanner --version 2>/dev/null || echo 'No disponible')"
echo "   - Dependencias: $(ls node_modules | wc -l) paquetes instalados"
echo "   - Variables de entorno: $(wc -l < .env) líneas configuradas"

print_message "🎉 ¡Entorno configurado exitosamente!"
print_message "🚀 Ahora puedes ejecutar: ./quality-gate.sh"
