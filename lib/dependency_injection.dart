import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/data/repositories/developer/developer_repository_mock.dart';
import 'package:mi_perfil_dev/data/repositories/localization/localization_repository_impl.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/repositories/localization_repository.dart';
import 'package:mi_perfil_dev/domain/use_cases/developer_info_use_case.dart';
import 'package:mi_perfil_dev/domain/use_cases/load_use_case.dart';
import 'package:mi_perfil_dev/domain/use_cases/toggle_hire_developer_use_case.dart';
import 'package:mi_perfil_dev/presentation/states/developer_state_impl.dart';
import 'package:mi_perfil_dev/presentation/states/localization_state_impl.dart';

//#region ------------- repositories -------------------------//
final developerRepositoryProvider = Provider<DeveloperRepository>(
  (ref) => DeveloperRepositoryMock(),
);
final localizationRepositoryProvider = Provider<LocalizationRepository>(
  (ref) => LocalizationRepositoryImpl(),
);
//#endregion repositories

//#region ------------- States -------------------------//
final developerStateProvider =
    NotifierProvider<DeveloperStateImpl, DeveloperEntity?>(
      DeveloperStateImpl.new,
    );
final localizationStateProvider =
    NotifierProvider<LocalizationStateImpl, Map<String, String>>(
      LocalizationStateImpl.new,
    );
//#endregion ---------- States ------------------------//

//#region ------------- use cases -------------------------//
final loadUseCaseProvider = Provider<LoadUseCase>(
  (ref) => LoadUseCase(
    localizationState: ref.read(localizationStateProvider.notifier),
  ),
);
//#region ------------- developer -------------------------//
final developerInfoUseCaseProvider = Provider<DeveloperInfoUseCase>(
  (ref) => DeveloperInfoUseCase(
    repository: ref.read(developerRepositoryProvider),
    developerState: ref.read(developerStateProvider.notifier),
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
