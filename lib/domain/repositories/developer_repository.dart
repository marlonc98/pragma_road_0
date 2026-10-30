import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/core/async_state.dart';

abstract class DeveloperRepository {
  Future<AsyncState<DeveloperEntity>> getDeveloperInfo();
  Future<AsyncState<void>> toggleHiredStatus(bool hired);
}
