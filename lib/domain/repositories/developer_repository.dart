import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';

abstract class DeveloperRepository {
  Future<PetitionStatusEntity<DeveloperEntity>> getDeveloperInfo();
  Future<PetitionStatusEntity<void>> toggleHiredStatus(bool hired);
}
