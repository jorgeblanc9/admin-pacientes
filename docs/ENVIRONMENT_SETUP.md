# Configuración del Entorno - Admin Pacientes

## 🚀 Configuración Automática Completa

### Opción 1: Script Automático (Recomendado)
```bash
# Configurar todo el entorno automáticamente
./setup-environment.sh

# O usando Makefile
make setup-full
```

### Opción 2: Configuración Manual
```bash
# 1. Usar la versión correcta de Node.js
nvm use

# 2. Instalar dependencias
npm install

# 3. Configurar variables de entorno
# (El script lo hace automáticamente)

# 4. Ejecutar quality gate
./quality-gate.sh
```

## 📋 Requisitos Previos

### 1. NVM (Node Version Manager)
```bash
# Instalar NVM si no lo tienes
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Reiniciar terminal o ejecutar
source ~/.bashrc
```

### 2. Verificar NVM
```bash
nvm --version
# Debería mostrar la versión de NVM
```

## 🔧 Configuración del Proyecto

### Archivo `.nvmrc`
```bash
# Contenido actual
22.18.0
```

### Versión de Node.js Requerida
- **Versión**: 22.18.0
- **Gestor**: NVM
- **Verificación**: `node --version`

## 🛠️ Scripts Disponibles

### `setup-environment.sh`
Configuración completa del entorno:
- ✅ Configura NVM con la versión correcta
- ✅ Instala dependencias de npm
- ✅ Crea archivo `.env` con variables de SonarQube
- ✅ Instala sonar-scanner globalmente
- ✅ Genera cobertura de código inicial
- ✅ Verifica toda la configuración

### `quality-gate.sh`
Ejecuta el análisis de SonarQube:
- ✅ Usa la versión correcta de Node.js
- ✅ Lee variables desde `.env`
- ✅ Genera cobertura si es necesario
- ✅ Ejecuta análisis de calidad

## 📊 Verificación del Entorno

### Comandos de Verificación
```bash
# Verificar versión de Node.js
node --version
# Debería mostrar: v22.18.0

# Verificar npm
npm --version

# Verificar NVM
nvm list
# Debería mostrar la versión 22.18.0 como activa

# Verificar sonar-scanner
sonar-scanner --version

# Verificar archivos de configuración
ls -la .env sonar-project.properties
```

### Información del Proyecto
```bash
# Ver dependencias instaladas
npm list --depth=0

# Ver scripts disponibles
npm run

# Ver cobertura de código
npm run test:unit:coverage
```

## 🚨 Troubleshooting

### Problema: "NVM no está instalado"
```bash
# Solución: Instalar NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
```

### Problema: "Versión de Node.js incorrecta"
```bash
# Solución: Usar la versión correcta
nvm use
# O instalar si no existe
nvm install 22.18.0
nvm use 22.18.0
```

### Problema: "sonar-scanner no está instalado"
```bash
# Solución: Instalar sonar-scanner
npm install -g sonarqube-scanner
```

### Problema: "Archivo .env no encontrado"
```bash
# Solución: Crear archivo .env
./setup-environment.sh
```

### Problema: "Dependencias no instaladas"
```bash
# Solución: Instalar dependencias
npm install
```

## 🔄 Flujo de Trabajo Recomendado

### 1. Configuración Inicial (Primera vez)
```bash
# Clonar repositorio
git clone <repo-url>
cd admin-pacientes

# Configurar entorno completo
./setup-environment.sh
```

### 2. Desarrollo Diario
```bash
# Cambiar a la versión correcta de Node.js
nvm use

# Instalar nuevas dependencias (si las hay)
npm install

# Ejecutar pruebas
npm run test:unit

# Ejecutar quality gate
./quality-gate.sh
```

### 3. Antes de Commit
```bash
# Ejecutar todas las pruebas
npm run test:all

# Ejecutar quality gate
./quality-gate.sh

# Verificar linting
npm run lint
```

## 📈 Monitoreo del Entorno

### Variables de Entorno Activas
```bash
# Ver variables de SonarQube
echo $SONAR_PROJECT_KEY
echo $SONAR_HOST_URL
echo $SONAR_TOKEN
```

### Estado del Proyecto
```bash
# Verificar estado general
npm run test:quality

# Ver cobertura actual
npm run test:unit:coverage

# Ver dependencias desactualizadas
npm outdated
```

## 🔒 Seguridad

### Archivos Sensibles
- **`.env`**: Variables de entorno (incluido en `.gitignore`)
- **`sonar-project.properties`**: Configuración del proyecto
- **`.nvmrc`**: Versión de Node.js (público)

### Buenas Prácticas
1. **Nunca** subir `.env` al repositorio
2. **Siempre** usar `nvm use` antes de trabajar
3. **Verificar** la versión de Node.js antes de commits
4. **Ejecutar** quality gate antes de push

## 🎯 Comandos Rápidos

### Desarrollo
```bash
make run              # Ejecutar en desarrollo
make test-unit        # Pruebas unitarias
make test-e2e         # Pruebas E2E
make quality-gate     # Quality gate
```

### Configuración
```bash
make setup-full       # Configuración completa
make setup-env        # Solo variables de entorno
```

---

**Nota**: Siempre ejecuta `nvm use` antes de trabajar en el proyecto para asegurar que estás usando la versión correcta de Node.js.
