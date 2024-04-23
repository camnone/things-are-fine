import 'package:thingsarefine/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [
        TaskRoute(),
        HistoryRoute(),
        ChatRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            body: child,
            bottomNavigationBar: tabsRouter.activeIndex != 2
                ? BottomNavigationBar(
                    selectedItemColor: Color(0xFFfdba00),
                    unselectedItemColor: theme.hintColor.withOpacity(0.3),
                    currentIndex: tabsRouter.activeIndex,
                    onTap: (value) => _openPage(value, tabsRouter),
                    items: const [
                      BottomNavigationBarItem(
                        label: "Task",
                        icon: Icon(Icons.task),
                      ),
                      BottomNavigationBarItem(
                        label: "History",
                        icon: Icon(Icons.history),
                      ),
                      BottomNavigationBarItem(
                        label: "Chat",
                        icon: Icon(Icons.chat),
                      ),
                      BottomNavigationBarItem(
                        label: "Settings",
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    setState(() => tabsRouter.setActiveIndex(index));
  }
}
