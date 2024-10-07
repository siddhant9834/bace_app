part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent {}


class HomeButtonClickedEvent extends DrawerEvent{}
class SevaButtonClickedEvent extends DrawerEvent{}
class PhotosButtonClickedEvent extends DrawerEvent{}
class CalendarButtonClickedEvent extends DrawerEvent{}
class MembersButtonClickedEvent extends DrawerEvent{}
class SevaListButtonClickedEvent extends DrawerEvent{}

class MorningProgramButtonClickedEvent extends DrawerEvent{}
class StatusButtonClickedEevent extends DrawerEvent{
  final bool status;

  StatusButtonClickedEevent({required this.status});
}