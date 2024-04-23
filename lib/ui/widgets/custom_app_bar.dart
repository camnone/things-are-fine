import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.title, this.chatScreen});
  final String title;
  final bool? chatScreen;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      titleTextStyle: TextStyle(color: Colors.white),
      leading: widget.chatScreen != null
          ? GestureDetector(
              onTap: () async {
                final autoRouter = AutoTabsRouter.of(context);
                autoRouter.setActiveIndex(0);
              },
              child: const Icon(Icons.arrow_back))
          : null,
      pinned: true,
      backgroundColor: theme.primaryColor,
      title: Center(
        child: Text(
          style: TextStyle(fontSize: 24),
          widget.title,
        ),
      ),
      surfaceTintColor: Colors.transparent,
    );
  }
}
