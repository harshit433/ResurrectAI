part of 'landing_bloc_bloc.dart';

abstract class LandingEvent {}

class LandingBlocInitialEvent extends LandingEvent {}

class SignUpEvent extends LandingEvent {}

class LoginEvent extends LandingEvent {}

class GoogleLoginEvent extends LandingEvent {}
