import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routes.dart';
import 'bloc/landing_bloc_bloc.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreen createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingBloc, LandingState>(
      listener: (context, state) {
        if (state is LoginState) {
          Navigator.pushNamed(context, Routes.loginscreen);
        } else if (state is SignUpState) {
          Navigator.pushNamed(context, Routes.signupscreen);
        }
        // else if (state is GoogleLoginState) {
        //   Navigator.pushNamed(context, Routes.homescreen);
        // }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 90.h, 10.w, 0.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Chat with Legends,',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 65.sp,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300)),
                    Text('Gain Timeless Wisdom',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 27.sp,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300)),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Text(
                          'Connect with the minds of history and get guidance from the greats who shaped our world.',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontSize: 13.sp,
                              color: Colors.white70,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 80.h, left: 50.w, right: 50.w),
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
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text('OR',
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 15.sp,
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400)),
                          ),
                          Expanded(
                            child: Divider(
                              height: 45.h,
                              color: Colors.white,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            onPressed: () {
                              context.read<LandingBloc>().add(SignUpEvent());
                            },
                            child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Sign up with mail",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp),
                                )))),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            context.read<LandingBloc>().add(LoginEvent());
                          },
                          child: Text('Already have an account? Log in',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 13.sp,
                                  color: Colors.white70,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
