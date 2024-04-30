import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    this.margin,
    this.settings = false,
    this.height,
    this.width = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
  });
  final Widget child;
  final double width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool? settings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: settings == true ? theme.hoverColor : theme.hoverColor),
      child: child,
    );
  }
}
