abstract interface class AbstractSettingsRepository {
  bool isDarkThemeSelected();
  Future<void> setDarkThemeSelected(bool value);
}
