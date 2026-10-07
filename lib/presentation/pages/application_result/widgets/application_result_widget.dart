import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';
import 'package:mi_perfil_dev/presentation/widgets/button_widget.dart';

class ApplicationResultWidget extends ConsumerWidget {
  final IconData icon;
  final Color color;
  final String titleKey;
  final String descriptionKey;

  const ApplicationResultWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.titleKey,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localizationStateProvider);
    final i18n = ref.read(localizationStateProvider.notifier).translate;
    final name = ref.watch(developerStateProvider)?.name ?? '';
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 900),
                curve: Curves.elasticOut,
                builder: (context, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 96, color: color),
                ),
              ),
              const SizedBox(height: 32),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      i18n(titleKey),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      i18n(descriptionKey, values: {'name': name}),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ButtonWidget(
                onTap: () => context.pop(),
                text: i18n(TextConstants.applicationResultBack),
                type: ButtonType.light,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
