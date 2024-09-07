import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<HomeButtonClickedEvent>(homeButtonClickedEvent);
    on<PhotosButtonClickedEvent>(photosButtonClickedEvent);
    on<SevaButtonClickedEvent>(sevaButtonClickedEvent);
    on<CalendarButtonClickedEvent>(calendarButtonClickedEvent);
    on<MembersButtonClickedEvent>(membersButtonClickedEvent);

    on<SevaListButtonClickedEvent>(sevaListButtonClickedEvent);
  }

  FutureOr<void> homeButtonClickedEvent(
      HomeButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(HomeButtonClickedState());
  }

  FutureOr<void> photosButtonClickedEvent(
      PhotosButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(PhotosButtonClickedState());
  }

  FutureOr<void> sevaButtonClickedEvent(
      SevaButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(SevaButtonClickedState());
  }

  FutureOr<void> calendarButtonClickedEvent(
      CalendarButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(CalendarButtonClickedState());
  }

  FutureOr<void> membersButtonClickedEvent(
      MembersButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(MembersButtonClickedState());
  }

  FutureOr<void> sevaListButtonClickedEvent(
      SevaListButtonClickedEvent event, Emitter<DrawerState> emit) {
    emit(SevaListButtonClickedState());
  }
}
