part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeEventInitial extends HomeEvent {}

final class SelectTab extends HomeEvent {
  SelectTab({required this.current});
  final String current;
}

final class Drag extends HomeEvent {
  Drag(
      {required this.heightOfContainer,
      required this.context,
      required this.details});
  final double heightOfContainer;
  final BuildContext context;
  final DragUpdateDetails details;
}
