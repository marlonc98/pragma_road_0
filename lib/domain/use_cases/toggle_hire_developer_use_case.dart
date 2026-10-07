import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';

class ToggleHireDeveloperUseCase {
  final DeveloperRepository repository;

  ToggleHireDeveloperUseCase({required this.repository});
  
  Future<PetitionStatusEntity<void>> toggleHiredStatus(bool hired) async {
    return await repository.toggleHiredStatus(hired);
  }
}