abstract interface class InitAppInterfaceRepository {
  ///[инициализация приложения]
  Future<void> init();

  ///[инициализация af]
  Future<void> afStart();

  /// [проверка на состояние включена клоака или нет]
  Future<void> checkSettingsStatus();

  Future<void> generateSettingsLink();

  /// [показать webview]
  void showSettings();

  /// [показать приложение]
  void showApplication();

  Future<void> registerAppPamyatki();

  Map<String, dynamic> linkConstructor();
}
