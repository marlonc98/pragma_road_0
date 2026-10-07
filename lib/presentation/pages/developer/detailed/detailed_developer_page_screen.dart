import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_view_model.dart';
import 'package:mi_perfil_dev/presentation/widgets/loader_screen_widget.dart';

class DetailedDeveloperPageScreen extends StatelessWidget {
  final DetailedDeveloperPageViewModel vm;
  const DetailedDeveloperPageScreen({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vm.developer.data?.name ?? '')),
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
    final bio = developer.bio;
    return ListView(
      padding: EdgeInsets.zero,
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
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final value in [developer.role, bio, developer.email])
                if (value != null && value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
