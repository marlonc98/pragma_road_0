import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/widgets/application_result_widget.dart';

class NotHiredPage extends StatelessWidget {
  static const String route = '/developer/not-hired';
  const NotHiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationResultWidget(
      icon: Icons.heart_broken,
      color: Theme.of(context).colorScheme.error,
      titleKey: TextConstants.notHiredPageTitle,
      descriptionKey: TextConstants.notHiredPageDescription,
    );
  }
}
