# Configuración de SonarQube - Admin Pacientes

## 📋 Configuración de Variables de Entorno

Este proyecto utiliza un archivo `.env` para manejar las variables de entorno de SonarQube de forma segura.

## 🚀 Configuración Rápida

### 1. Configurar Variables de Entorno
```bash
# Opción 1: Usando el script automático
./setup-env.sh

# Opción 2: Usando Makefile
make setup-env

# Opción 3: Manual
cp .env.example .env
# Editar .env con tus credenciales
```

### 2. Ejecutar Quality Gate
```bash
# Opción 1: Directo
./quality-gate.sh

# Opción 2: Usando Makefile
make quality-gate
```

## 📁 Archivos de Configuración

### `.env` (Variables de Entorno)
```bash
# SonarQube Configuration
SONAR_PROJECT_KEY=Admin-pacientes
SONAR_HOST_URL=https://sonar.webnovawp.com
SONAR_TOKEN=sqp_6544e4f4fe74c1a8090d23340361f3f5b2bcebda

# SonarQube Analysis Settings
SONAR_SOURCES=.
SONAR_JAVASCRIPT_LCOV_REPORT_PATHS=coverage/lcov.info
SONAR_COVERAGE_EXCLUSIONS=**/*.test.js,**/*.spec.js,**/tests/**,**/cypress/**,**/node_modules/**
SONAR_TEST_INCLUSIONS=**/*.test.js,**/*.spec.js
SONAR_EXCLUSIONS=**/node_modules/**,**/dist/**,**/coverage/**,**/.git/**,**/cypress/**,**/*.config.js
```

### `sonar-project.properties` (Configuración del Proyecto)
```properties
# SonarQube Project Configuration
sonar.projectKey=Admin-pacientes
sonar.projectName=Admin-pacientes
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
```

## 🔒 Seguridad

### Variables Sensibles
- **SONAR_TOKEN**: Token de autenticación de SonarQube
- **Archivo .env**: Incluido en `.gitignore` para no subirse al repositorio

### Buenas Prácticas
1. **Nunca** subir el archivo `.env` al repositorio
2. **Siempre** usar `.env.example` como plantilla
3. **Rotar** tokens periódicamente
4. **Usar** diferentes tokens para desarrollo y producción

## 🛠️ Scripts Disponibles

### `setup-env.sh`
- Configura automáticamente el archivo `.env`
- Incluye todas las variables necesarias
- Verifica si el archivo ya existe antes de sobrescribir

### `quality-gate.sh`
- Lee variables desde `.env`
- Crea `sonar-project.properties` si no existe
- Ejecuta análisis de SonarQube
- Muestra resultados con colores

## 📊 Configuración de Análisis

### Cobertura de Código
- **Archivos de cobertura**: `coverage/lcov.info`
- **Exclusiones**: Archivos de test, node_modules, cypress
- **Inclusiones**: Archivos `.test.js` y `.spec.js`

### Exclusiones
- `**/node_modules/**` - Dependencias
- `**/dist/**` - Archivos de build
- `**/coverage/**` - Reportes de cobertura
- `**/.git/**` - Control de versiones
- `**/cypress/**` - Pruebas E2E
- `**/*.config.js` - Archivos de configuración

## 🔧 Personalización

### Modificar Configuración
1. **Variables de entorno**: Editar `.env`
2. **Configuración del proyecto**: Editar `sonar-project.properties`
3. **Exclusiones**: Modificar `sonar.exclusions` en `sonar-project.properties`

### Agregar Nuevas Variables
```bash
# En .env
NUEVA_VARIABLE=valor

# En quality-gate.sh
export NUEVA_VARIABLE
```

## 🚨 Troubleshooting

### Problemas Comunes

#### 1. "Archivo .env no encontrado"
```bash
# Solución: Crear archivo .env
./setup-env.sh
```

#### 2. "sonar-scanner no está instalado"
```bash
# Solución: Instalar sonar-scanner
npm install -g sonarqube-scanner
```

#### 3. "Token inválido"
```bash
# Solución: Verificar token en .env
cat .env | grep SONAR_TOKEN
```

#### 4. "No se encontró package.json"
```bash
# Solución: Ejecutar desde directorio raíz del proyecto
cd /ruta/al/proyecto
./quality-gate.sh
```

## 📈 Monitoreo

### Métricas de Calidad
- **Cobertura de código**: Mínimo 80%
- **Duplicaciones**: Máximo 3%
- **Vulnerabilidades**: 0 críticas
- **Code smells**: Máximo 5%

### Dashboard
- **URL**: https://sonar.webnovawp.com/dashboard?id=Admin-pacientes
- **Acceso**: Requiere autenticación con token

## 🔄 Integración con CI/CD

### GitHub Actions
```yaml
- name: Setup Environment
  run: |
    echo "SONAR_TOKEN=${{ secrets.SONAR_TOKEN }}" >> .env
    echo "SONAR_PROJECT_KEY=Admin-pacientes" >> .env
    echo "SONAR_HOST_URL=https://sonar.webnovawp.com" >> .env

- name: Run Quality Gate
  run: ./quality-gate.sh
```

### Variables de Entorno en CI/CD
- **SONAR_TOKEN**: Secret del repositorio
- **SONAR_PROJECT_KEY**: Variable de entorno
- **SONAR_HOST_URL**: Variable de entorno

---

**Nota**: El archivo `.env` contiene información sensible y no debe subirse al repositorio. Siempre usa el script `setup-env.sh` para configurar las variables de entorno.
