import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';

DeveloperEntity fakeDeveloper = DeveloperEntity(
  id: '1',
  name: 'Fake Developer',
  email: 'fake.developer@example.com',
  role: 'Flutter Developer',
  bio: 'This is a fake developer',
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
