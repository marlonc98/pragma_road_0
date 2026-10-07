import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/domain/constants/errors_constants.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_view_model.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/developer_feature_item_widget.dart';

class DetailedDeveloperPageScreen extends StatelessWidget {
  final DetailedDeveloperPageViewModel vm;
  const DetailedDeveloperPageScreen({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.developer.data?.name ?? 'Desarrollador'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (vm.developer.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final developer = vm.developer.data;
    if (vm.developer.isError || developer == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(vm.developer.error ?? ErrorsConstants.unknownError),
            TextButton(
              onPressed: vm.handleLoadDeveloper,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }
    final imageHeight = MediaQuery.of(context).size.height * 0.4;
    final placeholder = SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: const Icon(Icons.person, size: 120),
    );
    return Column(
      children: [
        developer.profileImageUrl == null
            ? placeholder
            : Image.network(
                developer.profileImageUrl!,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
              ),
        Expanded(
          child: Container(
            transform: Matrix4.translationValues(0, -20, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary
                        .withValues(alpha: 0.5),
                    Theme.of(context).colorScheme.primary
                        .withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: const Alignment(0, 0.01),
                ),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Correo'),
                    subtitle: Text(developer.email),
                  ),
                  if (developer.bio != null)
                    ListTile(
                      title: const Text('Biografía'),
                      subtitle: Text(developer.bio!),
                    ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 8,
                    children: [
                      DeveloperFeatureItemWidget(
                        title: 'Rol',
                        value: developer.role,
                        icon: Icons.work,
                      ),
                      DeveloperFeatureItemWidget(
                        title: 'Contratado',
                        value: developer.hired ? 'Sí' : 'No',
                        icon: Icons.handshake,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
