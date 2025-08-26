# Guía de Testing - Admin Pacientes

## 📋 Reglas de Cursor Implementadas

Este proyecto incluye reglas de Cursor que **OBLIGAN** la creación de pruebas para cada funcionalidad. Las reglas están ubicadas en `.cursor/rules/` y se aplican automáticamente.

### Reglas Activas

1. **`testing-standards.mdc`** - Estándares generales de testing
2. **`vue-testing-patterns.mdc`** - Patrones específicos para Vue.js
3. **`component-testing-checklist.mdc`** - Checklist obligatorio para componentes

## 🚀 Comandos de Testing

### Pruebas Unitarias (Vitest)

```bash
# Ejecutar todas las pruebas unitarias
npm run test:unit
make test-unit

# Ejecutar con cobertura
npm run test:unit:coverage
make test-coverage

# Modo watch (desarrollo)
npm run test:unit:watch

# Interfaz gráfica
npm run test:unit:ui
```

### Pruebas E2E (Cypress)

```bash
# Ejecutar pruebas E2E
npm run test:e2e
make test-e2e

# Modo desarrollo (interactivo)
npm run test:e2e:dev

# Modo headless
npm run test:e2e:headless
```

### Comandos Combinados

```bash
# Ejecutar todas las pruebas
npm run test:all
make test-all

# Quality gate completo
npm run test:quality
make test-quality
```

## 📁 Estructura de Testing Obligatoria

### Para Cada Componente

```
src/
├── components/
│   ├── MiComponente/
│   │   ├── MiComponente.vue
│   │   └── __tests__/
│   │       └── MiComponente.spec.js
│   └── ...
└── ...
```

### Para Pruebas E2E

```
cypress/
├── e2e/
│   ├── mi-funcionalidad.cy.js
│   └── ...
└── ...
```

## ✅ Checklist Obligatorio

### Antes de Crear un Componente

- [ ] Crear directorio `__tests__` junto al componente
- [ ] Crear archivo `[ComponentName].spec.js`
- [ ] Crear archivo E2E `[feature-name].cy.js`
- [ ] Agregar `data-testid` a elementos interactivos

### Testing Unitario

- [ ] Props testing
- [ ] Eventos testing
- [ ] Slots testing
- [ ] Computed properties testing
- [ ] Watchers testing

### Testing E2E

- [ ] Flujos de usuario completos
- [ ] Integración con otros componentes
- [ ] Validación de formularios
- [ ] Estados de carga/error/éxito

## 🎯 Data Test IDs Obligatorios

### Convención de Nombres

```vue
<template>
  <!-- Formularios -->
  <input data-testid="email-input" v-model="email" />
  <button data-testid="submit-button" @click="submit">Enviar</button>

  <!-- Navegación -->
  <a data-testid="home-link" href="/">Inicio</a>

  <!-- Estados -->
  <div data-testid="loading-spinner" v-if="loading">Cargando...</div>
  <div data-testid="error-message" v-if="error">{{ error }}</div>
</template>
```

## 📊 Métricas de Calidad

### Cobertura Mínima Requerida

- **Statements**: 80%
- **Branches**: 80%
- **Functions**: 80%
- **Lines**: 80%

### Tiempo de Ejecución

- **Pruebas unitarias**: < 2 segundos por componente
- **Pruebas E2E**: < 30 segundos por flujo

## 🔧 Configuración

### Archivos de Configuración

- `vitest.config.js` - Configuración de Vitest
- `cypress.config.js` - Configuración de Cypress
- `quality-gate.sh` - Script de SonarQube

### Dependencias de Testing

```json
{
  "devDependencies": {
    "@vue/test-utils": "^2.4.6",
    "vitest": "^3.2.4",
    "cypress": "^14.5.3",
    "jsdom": "^26.1.0"
  }
}
```

## 🚨 Excepciones

Solo se permiten excepciones para:

- Archivos de configuración
- Archivos de utilidades muy simples
- Componentes de presentación sin lógica

**Documentar siempre la razón de la excepción:**

```javascript
/**
 * EXCEPCIÓN DE TESTING:
 * - Razón: Componente de presentación sin lógica
 * - Impacto: Bajo
 * - Plan de mitigación: Testing E2E cubre la funcionalidad
 */
```

## 🔄 Integración con CI/CD

### Pipeline Obligatorio

```yaml
# .github/workflows/test.yml
- name: Run Unit Tests
  run: npm run test:unit

- name: Run E2E Tests
  run: npm run test:e2e

- name: Check Coverage
  run: npm run test:unit:coverage

- name: Quality Gate
  run: ./quality-gate.sh
```

## 📚 Recursos Adicionales

- [Documentación de Vitest](https://vitest.dev/)
- [Documentación de Cypress](https://docs.cypress.io/)
- [Vue Test Utils](https://test-utils.vuejs.org/)
- [Reglas de Cursor](.cursor/rules/)

## 🆘 Soporte

Si tienes problemas con las pruebas:

1. Verifica que todas las dependencias estén instaladas
2. Ejecuta `npm run test:unit:watch` para debugging
3. Revisa la cobertura con `npm run test:unit:coverage`
4. Consulta las reglas en `.cursor/rules/`

---

**Recuerda: Las pruebas son OBLIGATORIAS para cada funcionalidad. No se puede considerar una feature como completada sin sus pruebas correspondientes.**
