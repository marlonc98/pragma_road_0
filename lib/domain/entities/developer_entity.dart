class DeveloperEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profileImageUrl;
  final String? bio;
  final List<String>? skills;
  bool hired;

  DeveloperEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImageUrl,
    this.bio,
    this.hired = false,
    this.skills,
  });
}