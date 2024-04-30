import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';

class FirebaseRepository {
  FirebaseRepository({required FirebaseMessaging messaging})
      : _messaging = messaging;

  final FirebaseMessaging _messaging;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
  final appRepository = GetIt.I<AppRepository>();

  Future<String?> getFMC() async {
    return _messaging.getToken();
  }

  Future<AuthorizationStatus> reqPerm() async {
    final status = await _messaging.requestPermission();
    return status.authorizationStatus;
  }
}
