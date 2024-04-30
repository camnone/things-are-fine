import "package:thingsarefine/features/chat/view/chat_screen.dart";
import "package:thingsarefine/features/deaplink/view/deaplink.dart";
import "package:thingsarefine/features/history/view/history_screen.dart";
import "package:thingsarefine/features/home/home.dart";
import "package:thingsarefine/features/internet/view/internet.dart";
import "package:thingsarefine/features/loader/view/loader.dart";
import "package:thingsarefine/features/settings/view/settings_screen.dart";
import "package:thingsarefine/features/task/task.dart";
import "package:auto_route/auto_route.dart";
import "package:thingsarefine/features/web/view/web.dart";

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoaderRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: WebRoute.page,
          path: '/web',
        ),
        AutoRoute(
          page: DeaplinkRoute.page,
          path: '/redirect',
        ),
        AutoRoute(
          page: InternetRoute.page,
          path: '/internet',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          children: [
            AutoRoute(
              page: TaskRoute.page,
              path: 'task',
            ),
            AutoRoute(
              page: ChatRoute.page,
              path: 'chat',
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
            ),
            AutoRoute(
              page: HistoryRoute.page,
              path: 'history',
            ),
          ],
        ),
      ];
}
