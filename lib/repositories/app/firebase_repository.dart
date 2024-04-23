import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseRepository {
  FirebaseRepository({required FirebaseMessaging messaging})
      : _messaging = messaging;

  final FirebaseMessaging _messaging;

  Future<String?> getFMC() async {
    return _messaging.getToken();
  }

  Future<AuthorizationStatus> reqPerm() async {
    final status = await _messaging.requestPermission();
    return status.authorizationStatus;
  }
}
