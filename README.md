# CreditAnalyst

> Aplicación en Flutter para analizar el nivel de endeudamiento y clasificar el riesgo crediticio mediante reglas de negocio explícitas y comprobables.

![Flutter](https://img.shields.io/badge/Flutter-Dart-02569B?logo=flutter&logoColor=white)
![Estado](https://img.shields.io/badge/estado-en%20desarrollo-yellow)
![Metodología](https://img.shields.io/badge/testing-TDD-blue)

## Descripción

**CreditAnalyst** es un proyecto de desarrollo de software enfocado en el análisis básico del endeudamiento. Su objetivo es transformar datos financieros de entrada en un porcentaje y una categoría de riesgo comprensible.

El proyecto también funciona como un entorno de práctica de **Dart, Flutter, separación de responsabilidades, pruebas unitarias y desarrollo guiado por pruebas (TDD)**. Se construye por etapas, priorizando primero la lógica del dominio y después la interfaz, la integración y la persistencia.

> **Aviso:** Las categorías generadas son orientativas y dependen de reglas definidas en el proyecto. No constituyen una calificación crediticia oficial ni una recomendación financiera.

## Objetivos

- Calcular indicadores básicos de endeudamiento a partir de datos financieros.
- Clasificar el resultado en categorías de riesgo: **Bajo, Moderado, Alto y Muy alto**.
- Mostrar el porcentaje calculado junto con su clasificación.
- Mantener la lógica de negocio independiente de la interfaz de usuario.
- Probar los comportamientos del dominio antes de integrarlos en la aplicación.
- Incorporar progresivamente una interfaz y mecanismos de persistencia.

## Tecnologías

| Tecnología | Uso |
| --- | --- |
| **Flutter** | Desarrollo de la aplicación multiplataforma |
| **Dart** | Implementación de la lógica y la aplicación |
| **flutter_test** | Pruebas automatizadas |
| **flutter_lints** | Reglas de análisis estático |
| **Git y GitHub** | Control de versiones y seguimiento del desarrollo |

El repositorio incluye un directorio `supabase/`. Su presencia no implica que la integración de persistencia esté terminada.

## Arquitectura y flujo

Se sigue un enfoque de **separación por capas**, inspirado en principios de Clean Architecture:

| Capa | Responsabilidad |
| --- | --- |
| **Domain** | Reglas de negocio, cálculos, clasificación y entidades del dominio |
| **Application** | Casos de uso que coordinan las operaciones del dominio |
| **Presentation** | Formularios, pantallas y visualización de resultados en Flutter |
| **Data / Infrastructure** | Almacenamiento y comunicación con fuentes de datos |

Flujo de análisis ya implementado en Dart:

```text
Datos financieros del usuario
             |
             v
    Caso de uso / Application
             |
             v
     Cálculo de endeudamiento
             |
             v
     Clasificación de riesgo
             |
             v
  CreditAnalysisResult
```

El caso de uso `AnalyzeCreditUseCase` recibe el calculador y el clasificador por constructor. La interfaz Flutter todavía no usa este flujo. `CreditAnalysisResultFormatter` permite convertir un resultado en texto con `%` cuando exista una pantalla que lo presente.

## Funcionalidades trabajadas

### Clasificación del riesgo

El servicio `CreditRiskClassifier` clasifica un porcentaje de endeudamiento en una categoría de riesgo. Entre los escenarios cubiertos durante el desarrollo se encuentran:

| Porcentaje de ejemplo | Clasificación esperada |
| ---: | --- |
| 30 % | Bajo |
| 35 % | Moderado |
| 45 % | Alto |

También se ha trabajado la categoría **Muy alto**. Los ejemplos anteriores son casos de prueba y **no sustituyen la definición completa de los umbrales**, que debe consultarse en el código del clasificador.

### Formato del resultado

El servicio `CreditAnalysisResultFormatter` construye una representación textual del análisis. Un resultado de ejemplo es:

```text
Porcentaje de deuda: 35.0%
Categoría: Moderado
```

## Hoja de ruta

**Estado verificado: 30 de octubre de 2026.** Los puntos completados reflejan código y pruebas ejecutadas; el resto constituye el plan de evolución.

### Fase 1 — Fundamentos y reglas del dominio

- [x] Establecer la finalidad de la aplicación.
- [x] Definir las categorías básicas de riesgo.
- [x] Iniciar la separación de la lógica del dominio.
- [x] Documentar los umbrales y casos límite en SPEC-001 y SPEC-002.

### Fase 2 — Flujo de análisis crediticio **(completada)**

- [x] Trabajar con `CreditRiskClassifier` y sus pruebas unitarias.
- [x] Implementar y probar `CreditAnalysisResultFormatter`.
- [x] Cubrir ingreso no positivo, deudas negativas, deuda cero, decimales y límites de clasificación.
- [x] Implementar `AnalyzeCreditUseCase` y devolver `CreditAnalysisResult`.
- [x] Superar formato, análisis estático y suite de pruebas.

### Fase 3 — Integración con la interfaz

- [ ] Sustituir la pantalla de contador por un formulario para los seis montos.
- [ ] Conectar el formulario con `AnalyzeCreditUseCase` y presentar resultado o errores de validación.
- [ ] Probar el flujo de interacción en Flutter.

### Fase 4 — Experiencia de usuario

- [ ] Diseñar el formulario de entrada de datos.
- [ ] Mostrar porcentaje y clasificación de riesgo.
- [ ] Incorporar validaciones y mensajes de error.
- [ ] Probar los principales flujos de interacción.

### Fase 5 — Persistencia

- [ ] Definir si los análisis necesitan almacenamiento local o remoto.
- [ ] Diseñar modelos y repositorios de persistencia.
- [ ] Implementar y probar la solución elegida.

### Fase 6 — Integración

- [ ] Conectar la interfaz con los casos de uso.
- [ ] Integrar los servicios de dominio y la persistencia, si corresponde.
- [ ] Verificar el flujo completo de análisis.

### Fase 7 — Calidad y evolución

- [ ] Ampliar pruebas unitarias y de integración.
- [ ] Mejorar manejo de errores y experiencia de usuario.
- [ ] Documentar decisiones de arquitectura.
- [ ] Preparar una versión funcional para demostración.

## Estado actual y siguiente paso

**La Fase 2 está completada en la rama de revisión.** El flujo de dominio y aplicación calcula y clasifica el porcentaje; `flutter test` terminó con **42 pruebas aprobadas** y `flutter analyze` con **cero problemas**. La aplicación que se inicia con `flutter run` aún muestra el contador de ejemplo.

**Siguiente fase prevista:** conectar el caso de uso a un formulario Flutter y mostrar los mensajes de validación y el resultado. Consulta el [informe de Fase 2](docs/PHASE_2_REPORT.md) y la [guía de estudio](docs/PHASE_2_STUDY_GUIDE.md).

## Metodología de desarrollo

Se aplica **Test-Driven Development (TDD)** en las partes trabajadas del dominio:

1. **Red:** escribir una prueba que exprese el comportamiento esperado y observar el fallo.
2. **Green:** implementar el código mínimo necesario para que pase.
3. **Refactor:** mejorar el diseño sin modificar el comportamiento comprobado.

Cada avance debe buscar cambios pequeños, verificables y fáciles de revisar.

## Cómo ejecutar el proyecto

### Requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) compatible con la versión de Dart requerida por el proyecto.
- **Dart SDK `^3.13.2`**, según `pubspec.yaml`.
- Un editor compatible, como VS Code o Android Studio.
- Un dispositivo, emulador o navegador compatible con Flutter.

### Instalación

```bash
git clone https://github.com/Dancolm95/credit_analysis.git
cd credit_analysis
flutter pub get
```

### Ejecución

```bash
flutter run
```

Para elegir un destino específico, consulta los dispositivos disponibles:

```bash
flutter devices
flutter run -d <device_id>
```

### Pruebas y análisis estático

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter test
flutter analyze
```

> Estos cuatro comandos se ejecutaron desde la raíz el 30 de octubre de 2026 y pasaron. No se verificó la ejecución en dispositivos ni una integración continua.

## Organización del repositorio

Entre los directorios principales del repositorio se encuentran:

```text
credit_analysis/
├── lib/                  # Código Dart de la aplicación
├── test/                 # Pruebas automatizadas
├── docs/                 # Documentación complementaria
├── supabase/             # Archivos relacionados con Supabase
├── android/              # Proyecto Android
├── ios/                  # Proyecto iOS
├── web/                  # Proyecto web
├── linux/                # Proyecto Linux
├── macos/                # Proyecto macOS
├── windows/              # Proyecto Windows
├── pubspec.yaml          # Dependencias y configuración Flutter
└── README.md
```

Para conocer las rutas exactas de cada servicio y prueba, consulta los archivos dentro de `lib/` y `test/`.

## Alcance y limitaciones

- Es un proyecto **en desarrollo**, no un sistema de scoring crediticio validado.
- Las reglas de clasificación son parte de la lógica de la aplicación y pueden evolucionar.
- Las funcionalidades de interfaz, integración y persistencia del roadmap no deben considerarse finalizadas hasta su implementación y prueba.

## Autor

Desarrollado por [Dancolm95](https://github.com/Dancolm95).

Repositorio: [github.com/Dancolm95/credit_analysis](https://github.com/Dancolm95/credit_analysis)

