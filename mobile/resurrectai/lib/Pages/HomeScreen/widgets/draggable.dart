import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resurrectai/Pages/HomeScreen/bloc/home_bloc_bloc.dart';

class DraggableContainer extends StatelessWidget {
  final Widget tab;
  final double heightOfContainer;
  const DraggableContainer(
      {Key? key, required this.tab, required this.heightOfContainer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return current is Dragged || current is CurrentTabState;
      },
      builder: (context, state) {
        return GestureDetector(
          onVerticalDragUpdate: (details) {
            context.read<HomeBloc>().add(Drag(
                heightOfContainer: heightOfContainer,
                context: context,
                details: details));
            // heightOfContainer -= details.delta.dy;
            // if (heightOfContainer < 350.h) {
            //   heightOfContainer = 350.h;
            // }
            // if (heightOfContainer > MediaQuery.of(context).size.height - 100.h) {
            //   heightOfContainer = MediaQuery.of(context).size.height - 100.h;
            // }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            curve: Curves.easeOut,
            width: MediaQuery.of(context).size.width,
            height: heightOfContainer,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
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
        );
      },
    );
  }
}
