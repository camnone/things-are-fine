import 'package:shared_preferences/shared_preferences.dart';
import 'package:thingsarefine/repositories/settings/abstract_settings_repository.dart';

class SettingsRepository implements AbstractSettingsRepository {
  final SharedPreferences prefs;
  static const isDartThemeSelectedKey = "dark_theme_key";
  SettingsRepository({required this.prefs});
  @override
  bool isDarkThemeSelected() {
    return prefs.getBool(isDartThemeSelectedKey) ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool value) async {
    await prefs.setBool(isDartThemeSelectedKey, value);
  }
}
