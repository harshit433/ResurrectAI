import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:resurrectai/Pages/profile_screen.dart';
import '../routes.dart';

class HomeCallsWidget extends StatefulWidget {
  const HomeCallsWidget({super.key});

  @override
  State<HomeCallsWidget> createState() => _HomeCallsWidgetState();
}

class _HomeCallsWidgetState extends State<HomeCallsWidget> {
  List<Map<String, dynamic>> calls = [];

  @override
  void initState() {
    super.initState();
    getCalls();
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime);
    String formattedDate;

    // Check if the timestamp is from today
    if (difference.inDays == 0) {
      formattedDate = 'Today';
    } else if (difference.inDays == 1) {
      formattedDate = 'Yesterday';
    } else {
      formattedDate = '${difference.inDays} days ago';
    }

    // Formatting time in AM/PM
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return '$formattedDate, $formattedTime';
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

  Future<void> getCalls() async {
    try {
      List<Map<String, dynamic>> callsFetched = [];
      List<Map<String, dynamic>> documentIds = await getDocuments();
      for (int i = 0; i < documentIds.length; i++) {
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Interactions')
              .doc(documentIds[i]['id'])
              .collection('Calls')
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            var callsData = querySnapshot.docs.map((doc) {
              return {
                'Name': documentIds[i]['id'],
                'createdAt': doc['createdAt'] as Timestamp,
              };
            }).toList();

            callsFetched.addAll(callsData);
          }
        } catch (e) {
          print('Error fetching chats: $e');
        }
      }
      setState(() {
        calls = callsFetched;
        calls.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
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
          padding: EdgeInsets.only(left: 20.w),
          child: Text('All Calls',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins')),
        ),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10.h),
                shrinkWrap: true,
                itemCount: calls.length,
                itemBuilder: (context, index) {
                  final item = calls[index];
                  return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileScreen(
                              personality: item['Name'],
                            );
                          }));
                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundImage:
                              AssetImage('assets/images/${item['Name']}.jpg'),
                        ),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProfileScreen(
                              personality: item['Name'],
                            );
                          }));
                        },
                        child: Text(item['Name'],
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.call_made_outlined,
                              color: Color.fromRGBO(61, 74, 122, 1)),
                          Text(formatTimestamp(item['createdAt']),
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      const Color.fromRGBO(152, 158, 156, 1))),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.callscreen,
                                  arguments: item['Name']);
                            },
                            icon: const Icon(Icons.call_rounded,
                                color: Color.fromRGBO(152, 158, 156, 1)),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.videocam_outlined,
                                color: Color.fromRGBO(152, 158, 156, 1)),
                          ),
                        ],
                      ));
                }))
      ],
    );
  }
}
