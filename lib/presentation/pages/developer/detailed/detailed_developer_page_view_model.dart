import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/utils/view_model.dart';

class DetailedDeveloperPageViewModel
    extends ViewModel<DetailedDeveloperPage> {
  DetailedDeveloperPageViewModel({
    required super.context,
    required super.widget,
    required super.ref,
    required super.isMounted,
  }) {
    handleLoadDeveloper();
  }

  PetitionStatusEntity<DeveloperEntity> developer =
      PetitionStatusEntity<DeveloperEntity>.loading();

  void handleLoadDeveloper() async {
    developer = await ref.read(developerInfoUseCaseProvider).getDeveloperInfo();
    notifyListeners();
  }
}
