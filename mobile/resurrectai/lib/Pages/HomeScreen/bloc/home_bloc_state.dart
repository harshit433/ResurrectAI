part of 'home_bloc_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {
  HomeInitial();
  final String active = 'Messages';
  final Widget tab = const HomeMessagesWidget();
  final String page = 'Home';
  final double heightOfContainer = 350.h;
}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({required this.models, required this.profileImage});
  List<String> models = [];
  String profileImage = '';
}

final class CurrentTabState extends HomeState {
  CurrentTabState(
      {required this.active,
      required this.tab,
      required this.page,
      required this.heightOfContainer});
  final String active;
  final Widget tab;
  final String page;
  final double heightOfContainer;
}

final class Dragged extends HomeState {
  Dragged({required this.heightOfContainer});
  final double heightOfContainer;
}
