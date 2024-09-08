import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class AuthService {
  Future<void> signup(
      {required String name,
      required String description,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      Future<List<Map<String, dynamic>>> getDocumentIds() async {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('AI models');
        QuerySnapshot querySnapshot = await collection.get();

        List<Map<String, dynamic>> documentIds = querySnapshot.docs.map((doc) {
          return {
            "id": doc.id,
            "Intro": doc['Intro_message'] ?? 'Hi there',
          };
        }).toList();
        print("AI Models recieved data");
        print(documentIds);
        return documentIds;
      }

      Future<void> createsubcollections() async {
        List<Map<String, dynamic>> documentIds = await getDocumentIds();
        for (int i = 0; i < documentIds.length; i++) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Interactions')
              .doc(documentIds[i]['id'])
              .set({'id': documentIds[i]['id']});

          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Interactions')
              .doc(documentIds[i]['id'])
              .collection('Chats')
              .doc(Timestamp.now().toString())
              .set({
            'send': '',
            'recieve': documentIds[i]['Intro'],
          });
        }
        for (int i = 0; i < documentIds.length; i++) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Interactions')
              .doc(documentIds[i]['id'])
              .collection('Calls')
              .doc(Timestamp.now().toString())
              .set({
            'Name': documentIds[i]['id'],
            'createdAt': Timestamp.now(),
          });
        }
        // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .collection('Interactions')
        //     .doc(documentIds[0]['id'])
        //     .collection('Calls')
        //     .get();
        // for (var calldoc in querySnapshot.docs) {
        //   await calldoc.reference.delete();
        // }
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'Name': name,
        'Description': description,
        'createdAt': Timestamp.now(),
      });

      await createsubcollections();
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, Routes.homescreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    }
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, Routes.homescreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
  }

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // After sign-out, navigate to the login screen
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, Routes.loginscreen);
    } catch (e) {
      // Handle any errors that occur during sign-out
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign out. Please try again.')),
      );
    }
  }
  // Implement signup functionality here
}
