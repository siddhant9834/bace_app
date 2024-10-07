import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/core/side_drawer/domain/usecases/update_status_usecases.dart';
import 'package:mayapur_bace/features/seva/domain/usecases/user_list_usecases.dart';
import 'package:meta/meta.dart';

part 'seva_event.dart';
part 'seva_state.dart';

class SevaBloc extends Bloc<SevaEvent, SevaState> {
  SevaBloc() : super(SevaInitial()) {
    on<SevaEditEvent>(sevaUpdateEvent);
    on<HideEditSevaEvent>(hideUpdateSevaEvent);
    on<UpdateSevaEvent>(updateSevaEvent);
  }

  FutureOr<void> sevaUpdateEvent(
      SevaEditEvent event, Emitter<SevaState> emit) {
        emit(SevaEditState());
      }

  FutureOr<void> hideUpdateSevaEvent(HideEditSevaEvent event, Emitter<SevaState> emit) {
          emit(SevaEditState());

  }

  FutureOr<void> updateSevaEvent(UpdateSevaEvent event, Emitter<SevaState> emit)async{
        await locator<UpdateSevaUsecases>().callUpdateSeva(event.newSeva, event.userEmail);

  }
}
