import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/SplashScreen/bloc/splash_bloc_bloc.dart';
import '../../routes.dart';
import 'bloc/splash_bloc_event.dart';
import 'bloc/splash_bloc_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc splashBloc = SplashBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => splashBloc..add(LoggedInEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoggedInState) {
            Navigator.pushReplacementNamed(context, Routes.homescreen);
          } else if (state is SplashLoggedOutState) {
            Navigator.pushReplacementNamed(context, Routes.splashscreen1);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset('assets/images/logo.png',
                        height: 100.h, width: 100.w),
                  ),
                  const Text('resurrect.ai',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        fontFamily: 'Kanit',
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
