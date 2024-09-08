import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic personality;

  const ProfileScreen({super.key, required this.personality});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String personality;
  late Future<Map<String, dynamic>> modelFuture;

  @override
  void initState() {
    super.initState();
    personality = widget.personality;
    modelFuture = getDocuments();
  }

  Future<Map<String, dynamic>> getDocuments() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('AI models')
        .doc(personality)
        .get();

    return documentSnapshot.data() as Map<String, dynamic>;
  }

  double height_of_container = 350.0.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
            future: modelFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                Map<String, dynamic> model = snapshot.data!;
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 70.h, left: 15.w, right: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back,
                                  size: 20.r, color: Colors.white)),
                          Center(
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundImage: AssetImage(
                                  'assets/images/${model['Name']}.jpg'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              model['Name'],
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          Center(
                            child: Text(
                              model['Tag'],
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40.r,
                                height: 40.r,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.message_outlined,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.chatscreen,
                                        arguments: model['Name']);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                width: 40.r,
                                height: 40.r,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.call_outlined,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProfileScreen(
                                        personality: personality,
                                      );
                                    }));
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                width: 40.r,
                                height: 40.r,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.videocam_outlined,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                                  onPressed: () {
                                    // Add your onPressed logic here
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              Container(
                                width: 40.r,
                                height: 40.r,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.2),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.library_books_outlined,
                                    color: Colors.white,
                                    size: 25.r,
                                  ),
                                  onPressed: () {
                                    // Add your onPressed logic here
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            height_of_container -= details.delta.dy;
                            if (height_of_container < 350.h) {
                              height_of_container = 350.h;
                            }
                            if (height_of_container >
                                MediaQuery.of(context).size.height - 70.h) {
                              height_of_container =
                                  MediaQuery.of(context).size.height - 70.h;
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.easeOut,
                          width: MediaQuery.of(context).size.width,
                          height: height_of_container,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 20.h,
                                child: Divider(
                                  thickness: 3,
                                  indent: 150.w,
                                  endIndent: 150.w,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20.w, top: 10.h, right: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Display Name',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color.fromRGBO(
                                                121, 124, 122, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    Text(model['Name'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('Status',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color.fromRGBO(
                                                121, 124, 122, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    Text(model['Intro_message'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text('Description',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color.fromRGBO(
                                                121, 124, 122, 1),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                    Text(
                                        model['Description'] ??
                                            'This is a default description',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                );
              } else {
                return const Center(child: Text('Error fetching data'));
              }
            }),
      ),
    );
  }
}
