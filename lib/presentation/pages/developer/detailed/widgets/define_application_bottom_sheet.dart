import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';

/// Returns `true` for hire, `false` for not hire and `null` if dismissed.
Future<bool?> showDefineApplicationBottomSheet(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _DefineApplicationBottomSheet(),
  );
}

class _DefineApplicationBottomSheet extends ConsumerWidget {
  const _DefineApplicationBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localizationStateProvider);
    final i18n = ref.read(localizationStateProvider.notifier).translate;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              i18n(TextConstants.defineApplicationSheetTitle),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _OptionTile(
              label: i18n(TextConstants.defineApplicationHire),
              icon: Icons.celebration,
              color: Colors.green,
              onTap: () => Navigator.of(context).pop(true),
            ),
            const SizedBox(height: 12),
            _OptionTile(
              label: i18n(TextConstants.defineApplicationNotHire),
              icon: Icons.heart_broken,
              color: colorScheme.error,
              onTap: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
