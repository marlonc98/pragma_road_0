import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';

class ToggleHireDeveloperUseCase {
  final DeveloperRepository developerRepository;
  final DeveloperState developerState;

  ToggleHireDeveloperUseCase({required this.developerRepository, required this.developerState});
  
  Future<PetitionStatusEntity<void>> toggleHiredStatus(bool hired) async {
    final response = await developerRepository.toggleHiredStatus(hired);
    if(response.isSuccess){
      developerState.updateHiredStatus(hired);
    }
    return response;
  }
}