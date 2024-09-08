import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/profile_screen.dart';

class HomeContactsWidget extends StatefulWidget {
  const HomeContactsWidget({super.key});

  @override
  State<HomeContactsWidget> createState() => _HomeContactsWidgetState();
}

class _HomeContactsWidgetState extends State<HomeContactsWidget> {
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    QuerySnapshot querysnapshot =
        await FirebaseFirestore.instance.collection('AI models').get();
    List<Map<String, dynamic>> documentIds = querysnapshot.docs.map((doc) {
      return {
        'id': doc.id,
      };
    }).toList();
    return documentIds;
  }

  Future<void> getContacts() async {
    try {
      List<Map<String, dynamic>> contacts_fetched = [];
      List<Map<String, dynamic>> documentIds = await getDocuments();
      for (int i = 0; i < documentIds.length; i++) {
        try {
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('AI models')
              .doc(documentIds[i]['id'])
              .get();
          var model = documentSnapshot.data() as Map<String, dynamic>;

          if (model.isNotEmpty) {
            Map<String, dynamic> data = {};
            data['title'] = model['Name'];
            data['subtitle'] = model['Intro_message'];
            data['leadingImage'] = 'assets/images/${documentIds[i]['id']}.jpg';
            contacts_fetched.add(data);
          }
        } catch (e) {
          print('Error fetching chats: $e');
        }
      }
      setState(() {
        contacts = contacts_fetched;
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
          child: Text('All Contacts',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins')),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: contacts.length,
                padding: EdgeInsets.only(top: 10.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = contacts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfileScreen(
                          personality: item['title'],
                        );
                      }));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30.r,
                        backgroundImage:
                            AssetImage(item['leadingImage'] as String),
                      ),
                      title: Text(item['title'] as String,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins')),
                      subtitle: Text(item['subtitle'] as String,
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
                    ),
                  );
                }))
      ],
    );
  }
}
