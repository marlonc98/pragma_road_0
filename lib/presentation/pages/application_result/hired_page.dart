import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';
import 'package:mi_perfil_dev/presentation/pages/application_result/widgets/application_result_widget.dart';

class HiredPage extends StatelessWidget {
  static const String route = '/developer/hired';
  const HiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ApplicationResultWidget(
      icon: Icons.celebration,
      color: Colors.green,
      titleKey: TextConstants.hiredPageTitle,
      descriptionKey: TextConstants.hiredPageDescription,
    );
  }
}
