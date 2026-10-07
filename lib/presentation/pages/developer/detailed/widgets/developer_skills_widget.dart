import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mi_perfil_dev/dependency_injection.dart';
import 'package:mi_perfil_dev/presentation/constants/text_constants.dart';

class DeveloperSkillsWidget extends ConsumerStatefulWidget {
  final List<String> skills;

  const DeveloperSkillsWidget({super.key, required this.skills});

  @override
  ConsumerState<DeveloperSkillsWidget> createState() =>
      _DeveloperSkillsWidgetState();
}

class _DeveloperSkillsWidgetState extends ConsumerState<DeveloperSkillsWidget> {
  static const _animationDuration = Duration(milliseconds: 300);
  static const _spacing = 8.0;

  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    ref.watch(localizationStateProvider);
    final i18n = ref.read(localizationStateProvider.notifier).translate;
    final chips = [for (final skill in widget.skills) _SkillChip(label: skill)];

    return AnimatedCrossFade(
      duration: _animationDuration,
      sizeCurve: Curves.easeInOut,
      crossFadeState: _expanded
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: Row(
        children: [
          Expanded(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.black, Colors.black, Colors.transparent],
                stops: [0, 0.7, 1],
              ).createShader(bounds),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: [
                    for (final chip in chips)
                      Padding(
                        padding: const EdgeInsets.only(right: _spacing),
                        child: chip,
                      ),
                  ],
                ),
              ),
            ),
          ),
          _ToggleButton(
            label: i18n(TextConstants.developerSkillsSeeMore),
            icon: Icons.keyboard_arrow_down,
            onPressed: _toggle,
          ),
        ],
      ),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(spacing: _spacing, runSpacing: _spacing, children: chips),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: _ToggleButton(
              label: i18n(TextConstants.developerSkillsSeeLess),
              icon: Icons.keyboard_arrow_up,
              onPressed: _toggle,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const _ToggleButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            Icon(icon, size: 18, color: color),
          ],
        ),
      ),
    );
  }
}
