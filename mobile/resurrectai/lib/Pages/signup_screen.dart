import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/services/auth_service.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  child: Text('Sign Up with Email',
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
                      'Get chatting with friends and family today by signing up for our chat app!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 15.sp,
                          color: const Color.fromRGBO(121, 124, 123, 1),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200)),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
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
                    obscureText: true,
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
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: 'Description',
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
                                image:
                                    AssetImage("assets/images/background.png"),
                                fit: BoxFit.fitWidth)),
                        child: Text(
                          "Sign up",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
                        ), // button text
                      ),
                    ),
                    onTap: () async {
                      print(emailController.text);
                      await AuthService().signup(
                          name: nameController.text,
                          description: descController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
