import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';

DeveloperEntity fakeDeveloper = DeveloperEntity(
  id: '1',
  name: 'Marlon Alejandro Méndez Castañeda',
  email: 'marlonmz1998@gmail.com',
  role: 'Flutter Developer',
  bio: '',
  profileImageUrl: 'https://media.licdn.com/dms/image/v2/D4E35AQHmOU9XPapnMg/profile-framedphoto-shrink_400_400/B4EaBivfoSG8AU-/0/1788363013087?e=1792018800&v=beta&t=gZ_zveVrq3d39nanCTFUki9dXyDRJPF-IA6GY5nHymc',
);

class DeveloperRepositoryMock extends DeveloperRepository {
  @override
  Future<PetitionStatusEntity<DeveloperEntity>> getDeveloperInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    return PetitionStatusEntity.success(data: fakeDeveloper);
  }

  @override
  Future<PetitionStatusEntity<void>> toggleHiredStatus(bool hired) async {
    await Future.delayed(const Duration(seconds: 1));
    return PetitionStatusEntity.success();
  }
}
