import 'package:mi_perfil_dev/domain/core/async_state.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';

class ToggleHireDeveloperUseCase {
  final DeveloperRepository developerRepository;
  final DeveloperState developerState;

  ToggleHireDeveloperUseCase({
    required this.developerRepository,
    required this.developerState,
  });

  Future<AsyncState<void>> toggleHiredStatus(bool hired) async {
    final response = await developerRepository.toggleHiredStatus(hired);
    if (response.isSuccess) {
      developerState.updateHiredStatus(hired);
    }
    return response;
  }
}
