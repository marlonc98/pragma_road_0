import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/data/repositories/developer/developer_repository_mock.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/use_cases/developer_info_use_case.dart';
import 'package:mi_perfil_dev/domain/use_cases/toggle_hire_developer_use_case.dart';
import 'package:mi_perfil_dev/presentation/states/developer_state_impl.dart';

//#region ------------- repositories -------------------------//
final developerRepositoryProvider = Provider<DeveloperRepository>(
  (ref) => DeveloperRepositoryMock(),
);
//#endregion repositories

//#region ------------- States -------------------------//
final developerStateProvider =
    NotifierProvider<DeveloperStateImpl, DeveloperEntity?>(
  DeveloperStateImpl.new,
);
//#endregion ---------- States ------------------------//

//#region ------------- use cases -------------------------//
//#region ------------- developer -------------------------//
final developerInfoUseCaseProvider = Provider<DeveloperInfoUseCase>(
  (ref) => DeveloperInfoUseCase(
    repository: ref.read(developerRepositoryProvider),
  ),
);
final toggleHireDeveloperUseCaseProvider = Provider<ToggleHireDeveloperUseCase>(
  (ref) => ToggleHireDeveloperUseCase(
    developerRepository: ref.read(developerRepositoryProvider),
    developerState: ref.read(developerStateProvider.notifier),
  ),
);
//#endregion ---------- developer -------------------------//
//#endregion ---------- use cases -------------------------//
