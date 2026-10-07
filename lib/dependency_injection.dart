import 'package:get_it/get_it.dart';
import 'package:mi_perfil_dev/data/repositories/developer/developer_repository_mock.dart';
import 'package:mi_perfil_dev/domain/repositories/developer_repository.dart';
import 'package:mi_perfil_dev/domain/states/developer_state.dart';
import 'package:mi_perfil_dev/domain/use_cases/developer_info_use_case.dart';
import 'package:mi_perfil_dev/domain/use_cases/toggle_hire_developer_use_case.dart';
import 'package:mi_perfil_dev/presentation/states/developer_state_impl.dart';


class DependencyInjection {
  DependencyInjection() {
    GetIt getIt = GetIt.instance;
    //#region ------------- repositories -------------------------//
    getIt.registerSingleton<DeveloperRepository>(
      DeveloperRepositoryMock(),
    );
    //#endregion repositories

    final developerStateImpl = DeveloperStateImpl();

    //#region ------------- States -------------------------//
    getIt.registerSingleton<DeveloperState>(developerStateImpl);
    getIt.registerSingleton<DeveloperStateImpl>(developerStateImpl);
    //#endregion ---------- States ------------------------//

    //#region ------------- use cases -------------------------//
    //#region ------------- developer -------------------------//
    getIt.registerSingleton<DeveloperInfoUseCase>(
      DeveloperInfoUseCase(
        repository: getIt.get<DeveloperRepository>(),
      ),
    );
    getIt.registerSingleton<ToggleHireDeveloperUseCase>(
      ToggleHireDeveloperUseCase(
        developerRepository: getIt.get<DeveloperRepository>(),
        developerState: getIt.get<DeveloperState>(),
      ),
    );
    //#endregion ---------- developer -------------------------//
    //#endregion ---------- use cases -------------------------//
  }
}
