part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent {}


class HomeButtonClickedEvent extends DrawerEvent{}
class SevaButtonClickedEvent extends DrawerEvent{}
class PhotosButtonClickedEvent extends DrawerEvent{}
class CalendarButtonClickedEvent extends DrawerEvent{}

