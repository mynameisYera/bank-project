import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gradus/src/features/main/domain/current_entity.dart';

part 'current_event.dart';
part 'current_state.dart';

class CurrentBloc extends Bloc<CurrentEvent, CurrentState> {
  CurrentBloc() : super(LoadingCurrentState()) {
    on<LoadCurrentEvent>(_onLoadCurrents);
  }

  Future<void> _onLoadCurrents(
      LoadCurrentEvent event, Emitter<CurrentState> emit) async {
    emit(LoadingCurrentState());
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('current').get();
      List<CurrentEntity> book = CurrentEntity.fromDocumentList(snapshot.docs);
      emit(SuccessCurrentState(items: book));
    } catch (e) {
      emit(FailureCurrentState(error: e.toString()));
    }
  }
}
