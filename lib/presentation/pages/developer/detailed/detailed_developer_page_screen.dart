import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_view_model.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/developer_feature_item_widget.dart';
import 'package:mi_perfil_dev/presentation/widgets/loader_screen_widget.dart';

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
    return LoaderScreenWidget<DeveloperEntity>(
      status: vm.developer,
      onRetry: vm.handleLoadDeveloper,
      builder: _buildContent,
    );
  }

  Widget _buildContent(BuildContext context, DeveloperEntity developer) {
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
