part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpButtonClicked extends AuthEvent {}

final class LoggedInButtonClicked extends AuthEvent {}

final class LoggedInUserByToken extends AuthEvent {}

final class AuthSkipped extends AuthEvent {}
