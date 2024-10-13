import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'landing_bloc_event.dart';
part 'landing_bloc_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingBlocInitial()) {
    on<LoginEvent>((event, emit) {
      emit(LoginState());
    });
    on<SignUpEvent>((event, emit) {
      emit(SignUpState());
    });
    on<GoogleLoginEvent>((event, emit) {
      emit(GoogleLoginState());
    });
  }
}
