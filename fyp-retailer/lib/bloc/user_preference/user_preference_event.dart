part of 'user_preference_bloc.dart';

abstract class UserPreferenceEvent extends Equatable {
  const UserPreferenceEvent();

  @override
  List<Object> get props => [];
}

class ToggleFirstLogin extends UserPreferenceEvent {
  final bool? value;
  const ToggleFirstLogin({this.value});
}

class InitUserPreference extends UserPreferenceEvent {
  const InitUserPreference();
}

class ChangeLocaleEvent extends UserPreferenceEvent {
  final Locale locale;

  const ChangeLocaleEvent({required this.locale});
}
