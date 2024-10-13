import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resurrectai/services/auth_service.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginBlocInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(LoggingInState());

      final result = await AuthService().signin(
        email: event.email,
        password: event.password,
      );
      if (result == 'Success') {
        emit(LoggedInState());
      } else {
        emit(LoginErrorState(result));
      }
    });
  }
}
