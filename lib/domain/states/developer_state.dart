import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';

abstract class DeveloperState {
  DeveloperEntity? developer;
  void updateHiredStatus(bool hired);
}
