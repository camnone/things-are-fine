import 'package:thingsarefine/ui/ui.dart';
import 'package:flutter/material.dart';

class BaseCardContainer extends StatelessWidget {
  const BaseCardContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      child: child,
    );
  }
}
