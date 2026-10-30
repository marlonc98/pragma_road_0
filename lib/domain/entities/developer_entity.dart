/// Perfil del desarrollador que se muestra en la app y sobre el que se
/// toma la decisión de contratación.
class DeveloperEntity {
  final String id;
  final String name;
  final String email;

  /// Cargo o título profesional (por ejemplo, `"Flutter Developer"`), no un
  /// rol de permisos dentro de la app. Se muestra como encabezado del perfil;
  /// si está vacío, no se muestra.
  final String role;

  /// Imagen de portada del perfil. Acepta una ruta de asset
  /// (`assets/...`) o una URL `http(s)://...`. Si es `null`, se muestra un
  /// placeholder con un ícono de persona.
  final String? profileImageUrl;

  /// Descripción breve del perfil profesional. Si es `null` o vacía, la
  /// sección no se muestra.
  final String? bio;

  /// Tecnologías o habilidades del desarrollador (por ejemplo, `"Flutter"`,
  /// `"Dart"`), en el orden en que se muestran como chips. Si es `null` o
  /// vacía, la sección no se muestra.
  final List<String>? skills;

  /// Decisión de contratación tomada por quien revisa el perfil:
  /// - `null`: todavía no hay decisión; se muestra el botón para definirla.
  /// - `true`: contratado.
  /// - `false`: no contratado.
  ///
  /// No es `final` porque se actualiza en memoria con
  /// `DeveloperState.updateHiredStatus` después de que el repositorio
  /// guarda la decisión.
  bool? hired;

  DeveloperEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImageUrl,
    this.bio,
    this.hired,
    this.skills,
  });
}
