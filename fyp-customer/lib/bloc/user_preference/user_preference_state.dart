part of 'user_preference_bloc.dart';

class UserPreferenceState extends Equatable {
  const UserPreferenceState({
    required this.isFirstLogin,
    required this.locale,
  });
  final bool isFirstLogin;
  final Locale locale;

  @override
  List<Object> get props => [isFirstLogin, locale];

  UserPreferenceState copyWith({
    bool? isFirstLogin,
    Locale? locale,
  }) {
    return UserPreferenceState(
      isFirstLogin: isFirstLogin ?? this.isFirstLogin,
      locale: locale ?? this.locale,
    );
  }
}
