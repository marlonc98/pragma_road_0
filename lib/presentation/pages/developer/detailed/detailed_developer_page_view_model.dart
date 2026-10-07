import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/not_hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/define_application_bottom_sheet.dart';
import 'package:mi_perfil_dev/presentation/utils/view_model.dart';

class DetailedDeveloperPageViewModel extends ViewModel<DetailedDeveloperPage> {
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

  Future<void> handleDefineApplication() async {
    final hired = await showDefineApplicationBottomSheet(context);
    if (hired == null || !mounted) return;
    final response = await ref
        .read(toggleHireDeveloperUseCaseProvider)
        .toggleHiredStatus(hired);
    if (!mounted) return;
    notifyListeners();
    if (!response.isSuccess) {
      // Solo molestando, para hacer tediosos el rechazar
      final i18n = ref.read(localizationStateProvider.notifier).translate;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(i18n(response.error ?? ''))));
      return;
    }
    // ignore: use_build_context_synchronously
    context.push(hired ? HiredPage.route : NotHiredPage.route);
  }
}
