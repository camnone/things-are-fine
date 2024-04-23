import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:thingsarefine/repositories/settings/abstract_settings_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final AbstractSettingsRepository _settingsRepository;
  ThemeCubit({required AbstractSettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(const ThemeState(Brightness.dark)) {
    _checkSelectedTheme();
  }

  Future<void> setTheme(Brightness brightness) async {
    emit(ThemeState(brightness));
    await _settingsRepository
        .setDarkThemeSelected(brightness == Brightness.dark);
  }

  void _checkSelectedTheme() {
    final brightness = _settingsRepository.isDarkThemeSelected()
        ? Brightness.dark
        : Brightness.light;

    emit(ThemeState(brightness));
  }
}
