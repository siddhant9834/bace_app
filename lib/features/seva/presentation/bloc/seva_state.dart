part of 'seva_bloc.dart';

@immutable
sealed class SevaState {}

final class SevaInitial extends SevaState {}

class SevaEditState extends SevaState{}

class SevaHideEditState extends SevaState{}

class SevaUpdateState extends SevaState{}
