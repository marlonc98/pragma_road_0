import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';

class DeveloperInfoUseCase {
  final DeveloperRepository repository;
  final DeveloperState developerState;

  DeveloperInfoUseCase({
    required this.repository,
    required this.developerState,
  });

  Future<PetitionStatusEntity<DeveloperEntity>> getDeveloperInfo() async {
    final response = await repository.getDeveloperInfo();
    if (response.isSuccess) {
      developerState.developer = response.data;
    }
    return response;
  }
}
