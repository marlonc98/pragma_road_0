import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/domain/entities/developer_entity.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/detailed_developer_page_view_model.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/define_application_widget.dart';
import 'package:mi_perfil_dev/presentation/pages/developer/detailed/widgets/developer_skills_widget.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imageHeight = (MediaQuery.of(context).size.height * 0.35).clamp(
      220.0,
      360.0,
    );
    final placeholder = Container(
      height: imageHeight,
      width: double.infinity,
      color: colorScheme.primary.withValues(alpha: 0.08),
      child: Icon(
        Icons.person,
        size: 96,
        color: colorScheme.primary.withValues(alpha: 0.4),
      ),
    );
    final bio = developer.bio;
    final skills = developer.skills;

    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        developer.profileImageUrl == null
            ? placeholder
            : Image.network(
                developer.profileImageUrl!,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, _, _) => placeholder,
              ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (developer.role.isNotEmpty)
                Text(
                  developer.role,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (developer.email.isNotEmpty) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: 16,
                      color: colorScheme.primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        developer.email,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (bio != null && bio.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  bio,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: colorScheme.onSurface.withValues(alpha: 0.85),
                  ),
                ),
              ],
              if (skills != null && skills.isNotEmpty) ...[
                const SizedBox(height: 24),
                DeveloperSkillsWidget(skills: skills),
              ],
              const SizedBox(height: 32),
              DefineApplicationWidget(
                hired: developer.hired,
                onTap: vm.handleDefineApplication,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
