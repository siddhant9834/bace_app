import 'dart:async';

import 'package:mayapur_bace/features/home/data/model/quote_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  var quoteDetails;

  HomeBloc({required this.quoteDetails}) : super(HomeInitial()) {
    // on<HomeEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ShowQuoteEvent>(showQuoteEvent);
  }

  FutureOr<void> showQuoteEvent(ShowQuoteEvent event, Emitter<HomeState> emit) {
    emit(ShowQuoteState(quoteDetails: quoteDetails));
  }
}
