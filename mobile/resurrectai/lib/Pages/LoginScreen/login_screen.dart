import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/LoginScreen/bloc/login_bloc_bloc.dart';
import 'package:resurrectai/routes.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final LoginBloc _loginBloc = LoginBloc();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoggedInState) {
            Navigator.pushReplacementNamed(context, Routes.homescreen);
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoggingInState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 10.w, right: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 50.w,
                            height: 50.h,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back))),
                        SizedBox(
                          height: 60.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text('Log in to resurrect.ai',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 20.sp,
                                  color: const Color.fromRGBO(61, 74, 122, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                              'Welcome back! Sign in using your social account or email to continue using our app.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(121, 124, 123, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.h, left: 50.w, right: 50.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2021/06/15/12/51/facebook-6338507_1280.png',
                                  width: 40.r,
                                  height: 40.r,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Image.network(
                                  'https://static-00.iconduck.com/assets.00/google-icon-2048x2048-pks9lbdv.png',
                                  width: 40.r,
                                  height: 40.r,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    'https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png',
                                    width: 40.r,
                                    height: 40.r,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  height: 45.h,
                                  color: const Color.fromRGBO(205, 209, 208, 1),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Text('OR',
                                    style: TextStyle(
                                        letterSpacing: 2,
                                        fontSize: 15.sp,
                                        color: const Color.fromRGBO(
                                            124, 121, 123, 1),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400)),
                              ),
                              Expanded(
                                child: Divider(
                                  height: 45.h,
                                  color: const Color.fromRGBO(205, 209, 208, 1),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(121, 124, 123, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 15.sp,
                                  color: const Color.fromRGBO(121, 124, 123, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50.h,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/background.png"),
                                        fit: BoxFit.fitWidth)),
                                child: Text(
                                  "Log In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                ), // button text
                              ),
                            ),
                            onTap: () {
                              context.read<LoginBloc>().add(LogInEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text('Forgot password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 13.sp,
                                  color: const Color.fromRGBO(61, 74, 122, 1),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
