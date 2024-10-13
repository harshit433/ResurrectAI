import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/home_calls.dart';
import '../../Widgets/home_contacts.dart';
import '../../Widgets/home_messages.dart';
import '../../Widgets/home_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> models = [];
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    _getprofileImage();
    getDocuments();
  }

  Future<void> _getprofileImage() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          profileImage = documentSnapshot['profileImageUrl'];
        });
      }
    });
  }

  Future<void> getDocuments() async {
    QuerySnapshot querysnapshot =
        await FirebaseFirestore.instance.collection('AI models').get();
    List<String> documentIds = querysnapshot.docs.map((doc) {
      return doc.id;
    }).toList();
    setState(() {
      models = documentIds;
    });
  }

  Widget tab = const HomeMessagesWidget();
  String active = 'Messages';
  String page = 'Home';

  double height_of_container = 350.0.h;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.messenger_outline),
                  color: active == 'Messages'
                      ? const Color.fromRGBO(61, 74, 122, 1)
                      : const Color.fromRGBO(121, 124, 123, 0.4),
                  onPressed: () {
                    setState(() {
                      tab = const HomeMessagesWidget();
                      active = 'Messages';
                      page = 'Home';
                      height_of_container = 350.h;
                    });
                  },
                ),
                Text('Message',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: active == 'Messages'
                            ? const Color.fromRGBO(61, 74, 122, 1)
                            : const Color.fromRGBO(121, 124, 123, 0.4),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins')),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.call_outlined),
                  color: active == 'Calls'
                      ? const Color.fromRGBO(61, 74, 122, 1)
                      : const Color.fromRGBO(121, 124, 123, 0.4),
                  onPressed: () {
                    setState(() {
                      tab = const HomeCallsWidget();
                      active = 'Calls';
                      page = 'Calls';
                      height_of_container =
                          MediaQuery.of(context).size.height - 200.h;
                    });
                  },
                ),
                Text('Calls',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: active == 'Calls'
                            ? const Color.fromRGBO(61, 74, 122, 1)
                            : const Color.fromRGBO(121, 124, 123, 0.4),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins')),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.contacts_outlined),
                  color: active == 'Contacts'
                      ? const Color.fromRGBO(61, 74, 122, 1)
                      : const Color.fromRGBO(121, 124, 123, 0.4),
                  onPressed: () {
                    setState(() {
                      tab = const HomeContactsWidget();
                      active = 'Contacts';
                      page = 'Contacts';
                      height_of_container =
                          MediaQuery.of(context).size.height - 200.h;
                    });
                  },
                ),
                Text('Contacts',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: active == 'Contacts'
                            ? const Color.fromRGBO(61, 74, 122, 1)
                            : const Color.fromRGBO(121, 124, 123, 0.4),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins')),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  color: active == 'Settings'
                      ? const Color.fromRGBO(61, 74, 122, 1)
                      : const Color.fromRGBO(121, 124, 123, 0.4),
                  onPressed: () {
                    setState(() {
                      tab = const HomeSettingsWidget();
                      active = 'Settings';
                      page = 'Settings';
                      height_of_container =
                          MediaQuery.of(context).size.height - 200.h;
                    });
                  },
                ),
                Text('Settings',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: active == 'Settings'
                            ? const Color.fromRGBO(61, 74, 122, 1)
                            : const Color.fromRGBO(121, 124, 123, 0.4),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins')),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
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
              padding: EdgeInsets.only(top: 70.h, left: 15.w, right: 15.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50.r,
                        height: 50.r,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.2),
                            shape: BoxShape.circle),
                        child: IconButton(
                          iconSize: 30.r,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                      Text(page,
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50.r,
                          height: 50.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: profileImage == ''
                                    ? const AssetImage(
                                        'assets/images/homeuserimage.png')
                                    : NetworkImage(profileImage)
                                        as ImageProvider,
                              ),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                  width: 70.r,
                                  height: 70.r,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.2),
                                      shape: BoxShape.circle),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.r,
                                        backgroundImage: const AssetImage(
                                            'assets/images/homeuserimage.png'),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 10.r,
                                          backgroundColor: Colors.white,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                            // size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text('Add Story',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')),
                            ],
                          ),
                          ...models.map((item) {
                            return Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 70.r,
                                        height: 70.r,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.2),
                                            shape: BoxShape.circle),
                                        child: CircleAvatar(
                                          radius: 30.r,
                                          backgroundImage: AssetImage(
                                              'assets/images/$item.jpg'),
                                        )),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(item,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
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
              // width: MediaQuery.of(context).size.width,
              // height: height_of_container,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    height_of_container -= details.delta.dy;
                    if (height_of_container < 350.h) {
                      height_of_container = 350.h;
                    }
                    if (height_of_container >
                        MediaQuery.of(context).size.height - 100.h) {
                      height_of_container =
                          MediaQuery.of(context).size.height - 100.h;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Expanded(child: Container(child: tab)),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
