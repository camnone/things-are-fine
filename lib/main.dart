import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/blocs/theme_cubit/theme_cubit.dart';
import 'package:thingsarefine/features/history/bloc/history_bloc.dart';
import 'package:thingsarefine/features/task/bloc/task_bloc.dart';
import 'package:thingsarefine/firebase_options.dart';
import 'package:thingsarefine/repositories/app/firebase_repository.dart';
import 'package:thingsarefine/repositories/chat/chat_repository.dart';
import 'package:thingsarefine/repositories/history/history_repository.dart';
import 'package:thingsarefine/repositories/history/models/history.dart';
import 'package:thingsarefine/repositories/settings/settings_repository.dart';
import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:thingsarefine/repositories/task/task_repository.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:thingsarefine/router/router.dart';
import 'package:thingsarefine/ui/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:realm/realm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebase = FirebaseFirestore.instance;
  final prefs = await SharedPreferences.getInstance();
  final config = Configuration.local([Task.schema, History.schema]);
  final realm = Realm(config);
  final messaging = FirebaseMessaging.instance;

  GetIt.I.registerSingleton(AppRepository(prefs: prefs));
  GetIt.I.registerLazySingleton(() => FirebaseRepository(messaging: messaging));
  GetIt.I.registerLazySingleton(
    () => ChatRepository(
      prefs: prefs,
      firestore: firebase,
      appRepository: GetIt.I<AppRepository>(),
      dio: Dio(),
    ),
  );

  runApp(
    ThingsAreFineApp(
      prefs: prefs,
      realm: realm,
      firebase: firebase,
    ),
  );
}

class ThingsAreFineApp extends StatefulWidget {
  const ThingsAreFineApp({
    super.key,
    required this.realm,
    required this.prefs,
    required this.firebase,
  });
  final Realm realm;
  final SharedPreferences prefs;
  final FirebaseFirestore firebase;
  @override
  State<ThingsAreFineApp> createState() => _ThingsAreFineAppState();
}

class _ThingsAreFineAppState extends State<ThingsAreFineApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final taskRepository = TaskRepository(realm: widget.realm);
    final historyRepository = HistoryRepository(realm: widget.realm);
    final settingsRepository = SettingsRepository(prefs: widget.prefs);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
            taskRepository: taskRepository,
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              ThemeCubit(settingsRepository: settingsRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Things are Fine',
            theme: state.isDark ? lightTheme : darkTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
