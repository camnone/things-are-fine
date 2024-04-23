import 'package:thingsarefine/ui/ui.dart';
import 'package:flutter/material.dart';

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final VoidCallback? onTap;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        child: BaseContainer(
          settings: true,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
