import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Widgets/home_calls.dart';
import 'package:resurrectai/Widgets/home_contacts.dart';
import 'package:resurrectai/Widgets/home_messages.dart';
import 'package:resurrectai/Widgets/home_settings.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEventInitial>((event, emit) async {
      emit(HomeLoading());
      String image = await _getprofileImage();
      List<String> models = await getDocuments();
      emit(HomeLoaded(models: models, profileImage: image));
    });

    on<SelectTab>((event, emit) {
      if (event.current == 'Messages') {
        emit(CurrentTabState(
            active: 'Messages',
            tab: const HomeMessagesWidget(),
            page: 'Home',
            heightOfContainer: 350.h));
      } else if (event.current == 'Calls') {
        emit(CurrentTabState(
            active: 'Calls',
            tab: const HomeCallsWidget(),
            page: 'Calls',
            heightOfContainer: 350.h));
      } else if (event.current == 'Contacts') {
        emit(CurrentTabState(
            active: 'Contacts',
            tab: const HomeContactsWidget(),
            page: 'Contacts',
            heightOfContainer: 350.h));
      } else if (event.current == 'Settings') {
        emit(CurrentTabState(
            active: 'Settings',
            tab: const HomeSettingsWidget(),
            page: 'Setting',
            heightOfContainer: 350.h));
      }
    });

    on<Drag>((event, emit) {
      print(event.heightOfContainer);
      double height = event.heightOfContainer;
      height -= event.details.delta.dy;
      if (height < 350.h) {
        height = 350.h;
      }
      if (height > MediaQuery.of(event.context).size.height - 100.h) {
        height = MediaQuery.of(event.context).size.height - 100.h;
      }
      emit(Dragged(heightOfContainer: height));
    });
  }
}

Future<String> _getprofileImage() async {
  String result = '';
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      result = documentSnapshot['profileImageUrl'];
    }
  });
  return result;
}

Future<List<String>> getDocuments() async {
  QuerySnapshot querysnapshot =
      await FirebaseFirestore.instance.collection('AI models').get();
  List<String> documentIds = querysnapshot.docs.map((doc) {
    return doc.id;
  }).toList();
  return documentIds;
}
