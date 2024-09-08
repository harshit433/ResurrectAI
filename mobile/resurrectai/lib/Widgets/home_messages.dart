import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/profile_screen.dart';
import 'package:resurrectai/routes.dart';

class HomeMessagesWidget extends StatefulWidget {
  const HomeMessagesWidget({super.key});

  @override
  State<HomeMessagesWidget> createState() => _HomeMessagesWidgetState();
}

class _HomeMessagesWidgetState extends State<HomeMessagesWidget> {
  List<Map<String, dynamic>> messages = [];
  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    QuerySnapshot querysnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Interactions')
        .get();
    List<Map<String, dynamic>> documentIds = querysnapshot.docs.map((doc) {
      return {
        'id': doc.id,
      };
    }).toList();
    return documentIds;
  }

  Future<void> getMessages() async {
    try {
      List<Map<String, dynamic>> messages_fetched = [];
      List<Map<String, dynamic>> documentIds = await getDocuments();
      for (int i = 0; i < documentIds.length; i++) {
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Interactions')
              .doc(documentIds[i]['id'])
              .collection('Chats')
              .orderBy(FieldPath.documentId, descending: true)
              .limit(1)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            var message =
                querySnapshot.docs.first.data() as Map<String, dynamic>;
            Map<String, dynamic> data = {};
            data['title'] = documentIds[i]['id'];
            data['subtitle'] = message['recieve'];
            data['leadingImage'] = 'assets/images/${documentIds[i]['id']}.jpg';
            data['unread'] = 1;
            messages_fetched.add(data);
          }
        } catch (e) {
          print('Error fetching chats: $e');
        }
      }
      setState(() {
        messages = messages_fetched;
      });
    } catch (e) {
      print('Error fetching documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(61, 74, 122, 1),
                borderRadius: BorderRadius.circular(30.r)),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 8.w, top: 8.h, bottom: 8.h),
              child: Text('Chats',
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins')),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              padding: EdgeInsets.only(top: 10.h),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = messages[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      messages.removeAt(index);
                    });
                  },
                  background: Container(
                    color: const Color.fromRGBO(241, 246, 250, 1),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 30.r,
                      height: 30.r,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(240, 74, 76, 1),
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileScreen(
                            personality: item['title'],
                          );
                        }));
                      },
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(item['leadingImage']),
                      ),
                    ),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.chatscreen,
                            arguments: item['title']);
                      },
                      child: Text(item['title'],
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins')),
                    ),
                    subtitle: Text(item['subtitle'],
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins')),
                    trailing: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(240, 74, 76, 1),
                          shape: BoxShape.circle),
                      child: Text(item['unread'].toString(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins')),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
