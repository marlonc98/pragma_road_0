import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';

class DeveloperInfoUseCase {
  final DeveloperRepository repository;

  DeveloperInfoUseCase({required this.repository});
  
  Future<PetitionStatusEntity<DeveloperEntity>> getDeveloperInfo() async {
    return await repository.getDeveloperInfo();
  }
}