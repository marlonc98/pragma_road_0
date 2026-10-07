import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/domain/entities/petition_status_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/not_hired_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/define_application_bottom_sheet.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';
import 'package:mi_perfil_dev/presentation/utils/view_model.dart';
import 'package:mi_perfil_dev/presentation/widgets/confirmation_dialog_widget.dart';

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
    if (!await _confirmDecision(hired) || !mounted) return;
    final response = await ref
        .read(toggleHireDeveloperUseCaseProvider)
        .toggleHiredStatus(hired);
    if (!mounted) return;
    notifyListeners();
    if (!response.isSuccess) {
      final i18n = ref.read(localizationStateProvider.notifier).translate;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(i18n(response.error ?? ''))));
      return;
    }
    // ignore: use_build_context_synchronously
    context.push(hired ? HiredPage.route : NotHiredPage.route);
  }

  Future<bool> _confirmDecision(bool hired) async {
    final i18n = ref.read(localizationStateProvider.notifier).translate;
    if (hired) {
      return showConfirmationDialog(
        context,
        message: i18n(
          TextConstants.confirmHireMessage,
          values: {'name': developer.data?.name ?? ''},
        ),
        confirmText: i18n(TextConstants.confirmHireConfirm),
        cancelText: i18n(TextConstants.confirmCancel),
        icon: Icons.celebration,
      );
    }
    // Solo molestando, para hacer tedioso el rechazar
    final steps = [
      (
        TextConstants.confirmRejectSureMessage,
        TextConstants.confirmRejectSureConfirm,
        TextConstants.confirmCancel,
        Icons.help_outline,
        false,
      ),
      (
        TextConstants.confirmRejectThinkTwiceMessage,
        TextConstants.confirmRejectThinkTwiceConfirm,
        TextConstants.confirmRejectThinkTwiceCancel,
        Icons.psychology_alt,
        false,
      ),
      (
        TextConstants.confirmRejectSayNoMessage,
        TextConstants.confirmRejectSayNoConfirm,
        TextConstants.confirmRejectSayNoCancel,
        Icons.swap_horiz,
        true,
      ),
      (
        TextConstants.confirmRejectHeartMessage,
        TextConstants.confirmRejectHeartConfirm,
        TextConstants.confirmRejectHeartCancel,
        Icons.heart_broken,
        false,
      ),
      (
        TextConstants.confirmRejectFeelingsMessage,
        TextConstants.confirmRejectFeelingsConfirm,
        TextConstants.confirmRejectFeelingsCancel,
        Icons.sentiment_very_dissatisfied,
        false,
      ),
    ];
    for (final (message, confirm, cancel, icon, swapButtons) in steps) {
      if (!mounted) return false;
      final confirmed = await showConfirmationDialog(
        context,
        message: i18n(message),
        confirmText: i18n(confirm),
        cancelText: i18n(cancel),
        icon: icon,
        destructive: true,
        swapButtons: swapButtons,
      );
      if (!confirmed) return false;
    }
    return true;
  }
}
