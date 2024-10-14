import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/HomeScreen/bloc/home_bloc_bloc.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current is CurrentTabState;
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          return Container(
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
                      color: state.active == 'Messages'
                          ? const Color.fromRGBO(61, 74, 122, 1)
                          : const Color.fromRGBO(121, 124, 123, 0.4),
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(SelectTab(current: 'Messages'));
                      },
                    ),
                    Text('Message',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: state.active == 'Messages'
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
                      color: state.active == 'Calls'
                          ? const Color.fromRGBO(61, 74, 122, 1)
                          : const Color.fromRGBO(121, 124, 123, 0.4),
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(SelectTab(current: 'Calls'));
                      },
                    ),
                    Text('Calls',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: state.active == 'Calls'
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
                      color: state.active == 'Contacts'
                          ? const Color.fromRGBO(61, 74, 122, 1)
                          : const Color.fromRGBO(121, 124, 123, 0.4),
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(SelectTab(current: 'Contacts'));
                      },
                    ),
                    Text('Contacts',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: state.active == 'Contacts'
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
                      color: state.active == 'Settings'
                          ? const Color.fromRGBO(61, 74, 122, 1)
                          : const Color.fromRGBO(121, 124, 123, 0.4),
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(SelectTab(current: 'Settings'));
                      },
                    ),
                    Text('Settings',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: state.active == 'Settings'
                                ? const Color.fromRGBO(61, 74, 122, 1)
                                : const Color.fromRGBO(121, 124, 123, 0.4),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins')),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
