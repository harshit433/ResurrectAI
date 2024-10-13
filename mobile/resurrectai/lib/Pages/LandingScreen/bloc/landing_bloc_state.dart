part of 'landing_bloc_bloc.dart';

@immutable
sealed class LandingState {}

final class LandingBlocInitial extends LandingState {}

final class SignUpState extends LandingState {}

final class LoginState extends LandingState {}

final class GoogleLoginState extends LandingState {}
