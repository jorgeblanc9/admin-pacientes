# Variables de Entorno - Admin Pacientes

## 🔒 Configuración Segura de Variables de Entorno

### ⚠️ **IMPORTANTE**: Nunca incluir tokens en el código

Los tokens de acceso deben estar **SIEMPRE** en variables de entorno, nunca hardcodeados en el código.

## 📋 Variables Requeridas

### Archivo `.env` (crear en la raíz del proyecto)

```bash
# SonarQube Configuration
SONAR_PROJECT_KEY=Admin-pacientes
SONAR_HOST_URL=https://sonar.webnovawp.com
SONAR_TOKEN=your_sonar_token_here

# SonarQube Analysis Settings
SONAR_SOURCES=.
SONAR_JAVASCRIPT_LCOV_REPORT_PATHS=coverage/lcov.info
SONAR_COVERAGE_EXCLUSIONS=**/*.test.js,**/*.spec.js,**/tests/**,**/cypress/**,**/node_modules/**
SONAR_TEST_INCLUSIONS=**/*.test.js,**/*.spec.js
SONAR_EXCLUSIONS=**/node_modules/**,**/dist/**,**/coverage/**,**/.git/**,**/cypress/**,**/*.config.js
```

## 🔑 Cómo Obtener el Token de SonarQube

### 1. Acceder a SonarQube

- Ve a: https://sonar.webnovawp.com
- Inicia sesión con tu cuenta

### 2. Generar Token

- Ve a **User > My Account > Security**
- Haz clic en **"Generate Tokens"**
- Dale un nombre descriptivo (ej: "Admin-pacientes-dev")
- Copia el token generado

### 3. Configurar en el Proyecto

```bash
# Opción 1: Usando el script automático
./scripts/setup-environment.sh

# Opción 2: Crear manualmente
cp .env.example .env
# Editar .env y agregar tu token
```

## 🚨 Seguridad

### ✅ **Buenas Prácticas**

- ✅ Usar variables de entorno para tokens
- ✅ Incluir `.env` en `.gitignore`
- ✅ Usar diferentes tokens por entorno
- ✅ Rotar tokens periódicamente

### ❌ **MALAS Prácticas**

- ❌ Hardcodear tokens en el código
- ❌ Subir `.env` al repositorio
- ❌ Usar el mismo token en todos los entornos
- ❌ Compartir tokens por chat/email

## 🔧 Configuración por Entorno

### Desarrollo Local

```bash
# .env.local (opcional)
SONAR_TOKEN=dev_token_here
```

### CI/CD Pipeline

```bash
# Variables de entorno del sistema
SONAR_TOKEN=${{ secrets.SONAR_TOKEN }}
```

### Producción

```bash
# Variables de entorno del servidor
SONAR_TOKEN=prod_token_here
```

## 📁 Estructura de Archivos

```
admin-pacientes/
├── .env                    # Variables de entorno (NO subir al repo)
├── .env.example           # Plantilla (SÍ subir al repo)
├── .gitignore             # Excluye .env
├── scripts/
│   └── setup-environment.sh  # Script de configuración
└── docs/
    └── ENVIRONMENT_VARIABLES.md  # Esta documentación
```

## 🛠️ Scripts de Configuración

### `scripts/setup-environment.sh`

- ✅ Solicita token de forma segura
- ✅ Crea archivo `.env` automáticamente
- ✅ Verifica configuración
- ✅ NO incluye tokens hardcodeados

### Uso del Script

```bash
# Ejecutar script de configuración
./scripts/setup-environment.sh

# El script te pedirá:
# 🔑 Ingresa tu token de SonarQube: [tu_token_aquí]
```

## 🔍 Verificación

### Comandos de Verificación

```bash
# Verificar que .env existe
ls -la .env

# Verificar que .env está en .gitignore
git check-ignore .env

# Verificar variables (sin mostrar token)
grep -v SONAR_TOKEN .env

# Verificar que el script funciona
./quality-gate.sh
```

## 🚨 Troubleshooting

### Problema: "Token no proporcionado"

```bash
# Solución: Ejecutar script de configuración
./scripts/setup-environment.sh
```

### Problema: "Archivo .env no encontrado"

```bash
# Solución: Crear archivo .env
cp .env.example .env
# Editar y agregar tu token
```

### Problema: "Token inválido"

```bash
# Solución: Generar nuevo token en SonarQube
# Actualizar .env con el nuevo token
```

## 📊 Variables por Entorno

| Variable            | Desarrollo                    | CI/CD                         | Producción                    |
| ------------------- | ----------------------------- | ----------------------------- | ----------------------------- |
| `SONAR_TOKEN`       | `dev_token`                   | `${{ secrets.SONAR_TOKEN }}`  | `prod_token`                  |
| `SONAR_HOST_URL`    | `https://sonar.webnovawp.com` | `https://sonar.webnovawp.com` | `https://sonar.webnovawp.com` |
| `SONAR_PROJECT_KEY` | `Admin-pacientes`             | `Admin-pacientes`             | `Admin-pacientes`             |

## 🔄 Rotación de Tokens

### Cuándo Rotar

- Cada 90 días (recomendado)
- Cuando un desarrollador sale del proyecto
- Si se sospecha compromiso
- Cambios de entorno

### Cómo Rotar

1. Generar nuevo token en SonarQube
2. Actualizar `.env` con nuevo token
3. Revocar token anterior
4. Verificar que todo funciona

---

**Recuerda**: La seguridad es responsabilidad de todos. Nunca compartas tokens ni los incluyas en el código.
