# Cómo contribuir a Mi Perfil Dev

Gracias por querer aportar. Esta guía explica el flujo de ramas, el estilo de commits y los checks que todo cambio debe pasar antes de integrarse. Para entender la arquitectura del proyecto, ver el [README](README.md#estructura-de-carpetas-y-arquitectura).

## Flujo de ramas

- `main`: siempre estable, lo que hay aquí debe compilar y pasar tests y linter.
- Cada cambio se hace en una rama corta creada desde `main`, con un prefijo según el tipo:
  - `feature/<descripcion-corta>` — funcionalidad nueva (ej. `feature/selector-idioma`)
  - `fix/<descripcion-corta>` — corrección de bugs
  - `refactor/<descripcion-corta>`, `docs/<...>`, `test/<...>`, `chore/<...>`
- Se abre un Pull Request hacia `main`. Antes de pedir revisión, la rama debe estar actualizada con `main` y pasar los checks de abajo.
- Se integra con **squash merge** para mantener un historial lineal y legible.

## Estilo de commits

Se usa [Conventional Commits](https://www.conventionalcommits.org/es/v1.0.0/), en español y en imperativo:

```
<tipo>(<alcance opcional>): <descripción corta>
```

Tipos: `feat`, `fix`, `refactor`, `test`, `docs`, `style`, `chore`. Ejemplos:

```
feat(developer): agregar sección de skills en el detalle
fix(localization): evitar recargar traducciones en cada build
test(hire): cubrir cancelación del flujo de rechazo
docs: documentar arquitectura en el README
```

## Correr tests

Los tests de widgets están en [test/widget_test.dart](test/widget_test.dart) y cubren el flujo completo: splash → detalle del desarrollador → contratar / rechazar (5 confirmaciones) / cancelar un rechazo.

```bash
flutter test
```

Con reporte de cobertura (se genera en `coverage/`, que no se versiona):

```bash
flutter test --coverage
```

## Linter y formato

Las reglas vienen de `flutter_lints` y se configuran en [analysis_options.yaml](analysis_options.yaml). Antes de abrir un PR:

```bash
dart format lib test
flutter analyze
```

`flutter analyze` debe terminar con `No issues found!`.

## Checklist antes de un PR

- [ ] `dart format lib test` sin cambios pendientes
- [ ] `flutter analyze` sin issues
- [ ] `flutter test` en verde
- [ ] Si el cambio agrega texto visible, la clave está en `TextConstants` y en `assets/translate_dictionaries/<locale>.json` (cada idioma)
- [ ] No se suben archivos locales ni credenciales (ver [Archivos que no se versionan](README.md#archivos-que-no-se-versionan))

