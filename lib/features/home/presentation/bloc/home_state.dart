part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

 class HomeInitial extends HomeState {
 
  
 }

 class ShowQuoteState extends HomeState{
   final QuoteDetails quoteDetails;

  ShowQuoteState({required this.quoteDetails});
 }
