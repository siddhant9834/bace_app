part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class ShowQuoteEvent extends HomeEvent {
  final String formattedDate;

  ShowQuoteEvent({required this.formattedDate});
}
