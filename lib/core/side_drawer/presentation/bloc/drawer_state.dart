part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {}

class HomeButtonClickedState extends DrawerState{}

class PhotosButtonClickedState extends DrawerState{}

class SevaButtonClickedState extends DrawerState{}

class CalendarButtonClickedState extends DrawerState{}