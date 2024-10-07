part of 'seva_bloc.dart';

@immutable
sealed class SevaEvent {}


class SevaEditEvent extends SevaEvent{

}

class HideEditSevaEvent extends SevaEvent{}


class UpdateSevaEvent extends SevaEvent{
  final String newSeva;
  final String userEmail;
  UpdateSevaEvent({required this.newSeva, required this.userEmail});
}