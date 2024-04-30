import 'dart:developer';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thingsarefine/firebase_options.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:thingsarefine/repositories/app/firebase_repository.dart';

import 'package:thingsarefine/repositories/app/init_ap_interface_repositroy.dart';
import 'package:thingsarefine/router/router.dart';
import 'package:intl/intl.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("push_url", message.data["url"]);
  } catch (e) {
    log(e.toString());
  }
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

class InitAppRepository implements InitAppInterfaceRepository {
  final Dio dio;
  final BuildContext context;
  static final AppsFlyerOptions _config = AppsFlyerOptions(
    afDevKey: "BDREFvBLEZQKVYEhZafc85",
    showDebug: true,
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
  );

  String locale = Intl.getCurrentLocale();
  final appRepository = GetIt.I<AppRepository>();
  final firebaseMessaging = GetIt.I<FirebaseRepository>();
  final AppsflyerSdk _appsflyerSdk = AppsflyerSdk(_config);
  DateTime now = DateTime.now();
  Map<String, dynamic> data = {};

  InitAppRepository({
    required this.context,
    required this.dio,
  }) {
    init();
  }

  Future<bool> checkInternetConnected() async {
    try {
      await dio.get("https://thingsarefines.com");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final isHaveInternet = await checkInternetConnected();

    if (isHaveInternet) {
      await checkFmcToken();
      await checkAfUid();
      checkLink();

      log("fmc token: ${appRepository.getValue(appRepository.afUid)}");
    } else {
      context.replaceRoute(const InternetRoute());
    }
  }

  void checkLink() {
    if (appRepository.getValue(appRepository.link) != null) {
      log("link ${appRepository.getValue(appRepository.link)}");
      showSettings();
    } else {
      afStart();
    }
  }

  Future<void> checkAfUid() async {
    if (appRepository.getValue(appRepository.afUid) == null) {
      final afUid = await _appsflyerSdk.getAppsFlyerUID();
      await appRepository.setValue(appRepository.afUid, afUid.toString());
    }
  }

  Future<void> checkFmcToken() async {
    if (appRepository.getValue(appRepository.fmcToken) == null) {
      if (appRepository.getValue(appRepository.rejectTime) == null) {
        await sendFmcPush();
      } else {
        final newDate = DateTime.parse(
            appRepository.getValue(appRepository.rejectTime).toString());
        if (now.isAfter(newDate)) {
          await sendFmcPush();
        }
      }
    }
  }

  Future<void> sendFmcPush() async {
    try {
      final AuthorizationStatus status = await firebaseMessaging.reqPerm();
      if (status == AuthorizationStatus.authorized) {
        final fmc = await firebaseMessaging.getFMC();
        await appRepository.setValue(appRepository.fmcToken, fmc.toString());
        await appRepository.clearKeyValue(appRepository.rejectTime);
      } else {
        DateTime newDateTime = now.add(const Duration(days: 2));
        await appRepository.setValue(
            appRepository.rejectTime, newDateTime.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> afStart() async {
    try {
      _appsflyerSdk.onInstallConversionData((res) {
        log("onInstallConversionData res: " + res.toString());

        data = res;
      });

      _appsflyerSdk.onAppOpenAttribution((res) {
        log("onAppOpenAttribution res: " + res.toString());
      });

      await _appsflyerSdk
          .initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      )
          .then((value) {
        checkSettingsStatus();
      }).onError((error, stackTrace) {
        log(error.toString());
        checkSettingsStatus();
      });

      _appsflyerSdk.enableFacebookDeferredApplinks(true);

      log("af init");
    } catch (e) {
      log("error init");
    }
  }

  @override
  Future<void> checkSettingsStatus() async {
    log("checkSettingsStatus");
    try {
      final response = await dio.get(
        "https://thingsarefines.com/api/check",
        options: Options(
          headers: {'Authorization': 'Bearer 9c8a667e868c44728f3347dd1f7440'},
        ),
      );

      if (response.statusCode == 200) {
        log("checkSettingsStatus status.code = ${response.statusCode}");
        generateSettingsLink();
      } else {
        log("checkSettingsStatus status.code = ${response.statusCode}");
        showApplication();
      }
    } catch (e) {
      log(" checkSettingsStatus error = ${e.toString()}");
      showApplication();
    }
  }

  @override
  Future<void> generateSettingsLink() async {
    try {
      final response = await dio.post(
        "https://thingsarefines.com/api/analytics",
        data: linkConstructor(),
        options: Options(
          headers: {'Authorization': 'Bearer 9c8a667e868c44728f3347dd1f7440'},
        ),
      );

      if (response.statusCode == 200) {
        log("generateSettingsLink status.code = ${response.statusCode}");
        await registerAppPamyatki();
        await appRepository.setValue(appRepository.link, response.data);
        showSettings();
      } else {
        log("generateSettingsLink status.code = ${response.statusCode}");
        showApplication();
      }
    } catch (e) {
      log(" generateSettingsLink error = ${e.toString()}");
      showApplication();
    }
  }

  @override
  Future<void> registerAppPamyatki() async {
    try {
      final data = {
        'appBundle': 'com.things.are.fine',
        'locale': locale,
        'deviceToken': appRepository.getValue(appRepository.fmcToken),
        'afId': appRepository.getValue(appRepository.afUid),
        'os': 'Android',
        'frProjectId': 'lucky-task-81c06'
      };

      await dio.post(
        "https://pamyatki.com/loguser",
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: data,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Map<String, dynamic> linkConstructor() {
    Map<String, dynamic> newData = {};
    try {
      data["data"]["userID"] = appRepository.getValue(appRepository.afUid);
      if (appRepository.getValue(appRepository.fmcToken) != null) {
        data["data"]["pushID"] = appRepository.getValue(appRepository.fmcToken);
      }

      newData = data["data"];
    } catch (e) {
      newData = {};
      newData["userID"] = appRepository.getValue(appRepository.afUid);
      if (appRepository.getValue(appRepository.fmcToken) != null) {
        newData["pushID"] = appRepository.getValue(appRepository.fmcToken);
      }
    }

    return newData;
  }

  Future<void> apsflyerLogs(String eventName) async {
    await _appsflyerSdk.logEvent(eventName, null);
  }

  @override
  void showApplication() {
    apsflyerLogs("start_app");
    context.pushRoute(const HomeRoute());
  }

  @override
  void showSettings() {
    apsflyerLogs("start_web");
    context.replaceRoute(WebRoute());
  }
}
