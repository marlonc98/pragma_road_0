import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';
import 'package:mi_perfil_dev/presentation/widgets/button_widget.dart';

class DefineApplicationWidget extends ConsumerWidget {
  final bool? hired;
  final Future<void> Function() onTap;

  const DefineApplicationWidget({
    super.key,
    required this.hired,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localizationStateProvider);
    final i18n = ref.read(localizationStateProvider.notifier).translate;

    if (hired == true) {
      return Center(
        child: _HiredButton(
          label: i18n(TextConstants.defineApplicationHired),
          onTap: onTap,
        ),
      );
    }

    final notHiredColor = Theme.of(context).colorScheme.error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hired == false) ...[
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: notHiredColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cancel, size: 16, color: notHiredColor),
                  const SizedBox(width: 6),
                  Text(
                    i18n(TextConstants.defineApplicationNotHired),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: notHiredColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        ButtonWidget(
          onTap: onTap,
          text: i18n(TextConstants.defineApplicationButton),
          icon: Icons.how_to_reg,
        ),
      ],
    );
  }
}

class _HiredButton extends StatelessWidget {
  static const _color = Colors.redAccent;

  final String label;
  final VoidCallback onTap;

  const _HiredButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, size: 20, color: _color),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
