import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../repositories/user_preference/user_preference_repository.dart';

part 'user_preference_event.dart';
part 'user_preference_state.dart';

class UserPreferenceBloc
    extends Bloc<UserPreferenceEvent, UserPreferenceState> {
  final UserPreferenceRepository userPreferenceRepository;
  UserPreferenceBloc({required this.userPreferenceRepository})
      : super(const UserPreferenceState(
          isFirstLogin: true,
          locale: Locale('en'),
        )) {
    on<ToggleFirstLogin>(_toggleFirstLogin);
    on<InitUserPreference>(_initUserPreference);
    on<ChangeLocaleEvent>(_changeLocale);
  }

  void _toggleFirstLogin(
      ToggleFirstLogin event, Emitter<UserPreferenceState> emit) {
    final isFirstLogin = event.value ?? !state.isFirstLogin;
    userPreferenceRepository.setValue(
        PreferenceKey.isFirstTimeLogin, isFirstLogin);
    emit(state.copyWith(isFirstLogin: isFirstLogin));
  }

  void _changeLocale(
      ChangeLocaleEvent event, Emitter<UserPreferenceState> emit) {
    userPreferenceRepository.setValue(
        PreferenceKey.locale, event.locale.languageCode.toString());
    emit(state.copyWith(locale: event.locale));
  }

  void _initUserPreference(
      InitUserPreference event, Emitter<UserPreferenceState> emit) async {
    final locale =
        await userPreferenceRepository.getValue(PreferenceKey.locale) ?? 'en';
    final isFirstLogin = await userPreferenceRepository
            .getValue(PreferenceKey.isFirstTimeLogin) ??
        true;
    emit(UserPreferenceState(
        isFirstLogin: isFirstLogin, locale: Locale(locale)));
  }
}
