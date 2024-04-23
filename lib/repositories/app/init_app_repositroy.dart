import 'dart:developer';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';

import 'package:thingsarefine/repositories/app/init_ap_interface_repositroy.dart';
import 'package:thingsarefine/router/router.dart';

class InitAppRepository implements InitAppInterfaceRepository {
  final Dio dio;
  final BuildContext context;
  static final AppsFlyerOptions _config = AppsFlyerOptions(
    afDevKey: "A6WHZdvdrF6wCXTqHZNzEd",
    showDebug: true,
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
  );
  final appRepository = GetIt.I<AppRepository>();
  final AppsflyerSdk _appsflyerSdk = AppsflyerSdk(_config);
  Map<String, dynamic> data = {};

  InitAppRepository({
    required this.context,
    required this.dio,
  }) {
    init();
  }

  @override
  void init() {
    if (appRepository.getValue(appRepository.link) != null) {}
    afStart();
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
        "https://bookofanubis.com/api/check",
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
        "https://bookofanubis.com/api/analytics",
        data: {},
        options: Options(
          headers: {'Authorization': 'Bearer 9c8a667e868c44728f3347dd1f7440'},
        ),
      );

      if (response.statusCode == 200) {
        log("generateSettingsLink status.code = ${response.statusCode}");
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

  void apsflyerLogs(String message) {
    log(message);
  }

  @override
  void showApplication() {
    apsflyerLogs("Запуск приложения");
    context.pushRoute(HomeRoute());
  }

  @override
  void showSettings() {
    apsflyerLogs("Запуск вебвью");
    context.replaceRoute(WebRoute());
  }
}
