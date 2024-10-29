import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gradus/src/features/main/domain/next_book_entity.dart';

part 'next_book_event.dart';
part 'next_book_state.dart';

class NextBookBloc extends Bloc<NextBookEvent, NextBookState> {
  NextBookBloc() : super(LoadingNextBookState()) {
    on<LoadNextBookEvent>(_onLoadMessages);
  }

  Future<void> _onLoadMessages(
      LoadNextBookEvent event, Emitter<NextBookState> emit) async {
    emit(LoadingNextBookState());
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('nextBook').get();
      List<NextBookEntity> books =
          NextBookEntity.fromDocumentList(snapshot.docs);
      emit(SuccessNextBookState(items: books));
    } catch (e) {
      emit(FailureNextBookState(error: e.toString()));
    }
  }
}
