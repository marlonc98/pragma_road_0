import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';

class DeveloperStateImpl extends Notifier<DeveloperEntity?>
    implements DeveloperState {
  @override
  DeveloperEntity? build() => null;

  @override
  DeveloperEntity? get developer => state;

  @override
  set developer(DeveloperEntity? developer) => state = developer;

  @override
  void updateHiredStatus(bool hired) {
    state?.hired = hired;
    ref.notifyListeners();
  }
}
