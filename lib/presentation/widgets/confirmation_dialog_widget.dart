import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/widgets/button_widget.dart';

/// Returns `true` only when the confirm button is pressed.
Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String message,
  required String confirmText,
  required String cancelText,
  IconData? icon,
  bool destructive = false,
  bool swapButtons = false,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => ConfirmationDialogWidget(
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      icon: icon,
      destructive: destructive,
      swapButtons: swapButtons,
    ),
  );
  return confirmed ?? false;
}

class ConfirmationDialogWidget extends StatelessWidget {
  final String message;
  final String confirmText;
  final String cancelText;
  final IconData? icon;
  final bool destructive;

  /// Puts the confirm button on the left with the cancel style, and cancel on
  /// the right with the confirm style.
  final bool swapButtons;

  static const confirmButtonKey = Key('confirmation_dialog_confirm');
  static const cancelButtonKey = Key('confirmation_dialog_cancel');

  const ConfirmationDialogWidget({
    super.key,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    this.icon,
    this.destructive = false,
    this.swapButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = destructive ? colorScheme.error : colorScheme.primary;
    // Swapped buttons also swap styles, so the layout looks exactly like a
    // regular dialog and confirm is camouflaged as cancel.
    final filledType = destructive
        ? ButtonType.errorFilled
        : ButtonType.primary;
    final cancelButton = ButtonWidget(
      key: cancelButtonKey,
      onTap: () => Navigator.of(context).pop(false),
      text: cancelText,
      type: swapButtons ? filledType : ButtonType.light,
    );
    final confirmButton = ButtonWidget(
      key: confirmButtonKey,
      onTap: () => Navigator.of(context).pop(true),
      text: confirmText,
      type: swapButtons ? ButtonType.light : filledType,
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: color),
              ),
              const SizedBox(height: 20),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: swapButtons ? confirmButton : cancelButton),
                const SizedBox(width: 12),
                Expanded(child: swapButtons ? cancelButton : confirmButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
