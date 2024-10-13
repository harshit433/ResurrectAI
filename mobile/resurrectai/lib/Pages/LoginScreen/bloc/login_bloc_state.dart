part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginBlocInitial extends LoginState {}

final class LoggingInState extends LoginState {}

final class LoggedInState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
