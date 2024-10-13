import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_bloc_event.dart';
import 'splash_bloc_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<LoggedInEvent>((event, emit) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoggedInState());
      } else {
        await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoggedOutState());
      }
    });
  }
}
