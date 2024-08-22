import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'seva_event.dart';
part 'seva_state.dart';

class SevaBloc extends Bloc<SevaEvent, SevaState> {
  SevaBloc() : super(SevaInitial()) {
    on<SevaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
