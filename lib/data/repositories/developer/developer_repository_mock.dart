import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

DeveloperEntity fakeDeveloper = DeveloperEntity(
  id: '1',
  name: 'Marlon Alejandro Méndez Castañeda',
  email: 'marlonmz1998@gmail.com',
  role: 'Flutter Developer',
  bio: 'Multimedia Engineer with over 6 years of experience in software development. Specialist in Flutter and React/TypeScript, with fluent English proficiency developed through direct collaboration with international companies. Expert in code architecture and scalability, with extensive experience in database management, implementation of integration testing, and knowledge in AI-driven development using Claude.',
  profileImageUrl: 'https://media.licdn.com/dms/image/v2/D4E35AQHmOU9XPapnMg/profile-framedphoto-shrink_400_400/B4EaBivfoSG8AU-/0/1788363013087?e=1792018800&v=beta&t=gZ_zveVrq3d39nanCTFUki9dXyDRJPF-IA6GY5nHymc',
  skills: [
    'Flutter',
    'Dart',
    'React',
    'TypeScript',
    'Node.js',
    'Python',
    'SQL',
    'NoSQL',
    'Git',
    'CI/CD',
  ],
);

class DeveloperRepositoryMock extends DeveloperRepository {
  final String key = 'developer_hired_status';
  @override
  Future<PetitionStatusEntity<DeveloperEntity>> getDeveloperInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hired = prefs.getBool(key);
    fakeDeveloper.hired = hired;
    return PetitionStatusEntity.success(data: fakeDeveloper);
  }

  @override
  Future<PetitionStatusEntity<void>> toggleHiredStatus(bool hired) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, hired);
    return PetitionStatusEntity.success();
  }
}
