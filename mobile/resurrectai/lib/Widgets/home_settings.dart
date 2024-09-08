import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../services/auth_service.dart';

class HomeSettingsWidget extends StatefulWidget {
  const HomeSettingsWidget({super.key});

  @override
  State<HomeSettingsWidget> createState() => _HomeSettingsWidgetState();
}

class _HomeSettingsWidgetState extends State<HomeSettingsWidget> {
  String? Name;
  String? Description;
  bool isLoading = true;
  String? error;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchFieldValue();
  }

  Future<void> _getprofileImage() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _imageUrl = documentSnapshot['profileImageUrl'];
        });
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
        });
        await _uploadImage();
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      if (_image == null) return;

      // Get a reference to the Firebase Storage bucket
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('images/$fileName');

      // Upload the file to Firebase Storage
      await imagesRef.putFile(File(_image!.path));

      // Get the download URL
      final downloadUrl = await imagesRef.getDownloadURL();

      setState(() {
        _imageUrl = downloadUrl;
      });

      // Save the image URL to Firestore
      await _saveImageUrl(downloadUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _saveImageUrl(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's document in Firestore
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Update the user's document with the image URL
        await userDocRef.update({
          'profileImageUrl': imageUrl,
        });
      }
    } catch (e) {
      print('Error saving image URL to Firestore: $e');
    }
  }

  Future<void> fetchFieldValue() async {
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      DocumentSnapshot documentSnapshot = await documentRef.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        setState(() {
          Name = data?['Name'];
          Description = data?['Description'];
          isLoading = false;
          _getprofileImage();
        });
      } else {
        setState(() {
          error = 'Document does not exist';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error fetching document: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : error != null
            ? Center(child: Text(error!))
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                  child: Column(
                    children: [
                      Row(children: [
                        GestureDetector(
                          onTap: () async {
                            _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 35.r,
                            backgroundImage: _imageUrl == ''
                                ? const AssetImage(
                                    'assets/images/homeuserimage.png')
                                : NetworkImage(_imageUrl) as ImageProvider,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Name!,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins')),
                            Text('Never give up',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins')),
                          ],
                        )
                      ]),
                      const SizedBox(height: 20),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.key_sharp,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Account',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('Privacy, security, change number',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Chats',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('Theme, wallpapers, chat history',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.notifications_none_outlined,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Notifications',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('Message, group & call tones',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.help_outline,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Help',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('FAQ, contact us, privacy policy',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.group_outlined,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Invite a friend',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('Share Resurrect AI with your friends',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.star_border_outlined,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Rate us on Play Store',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('Help us improve by rating us',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.info_outline,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('About',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        subtitle: Text('App version, developer info',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(222, 235, 255, 1)),
                          child: const Icon(
                            Icons.exit_to_app,
                            color: Color.fromRGBO(121, 124, 123, 0.4),
                          ),
                        ),
                        title: Text('Log out',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                        onTap: () {
                          AuthService().signOut(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
  }
}
