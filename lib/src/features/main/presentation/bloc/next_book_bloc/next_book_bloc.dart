import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gradus/src/features/main/domain/next_book_entity.dart';

part 'next_book_event.dart';
part 'next_book_state.dart';

class NextBookBloc extends Bloc<NextBookEvent, NextBookState> {
  NextBookBloc() : super(LoadingNextBookState()) {
    on<LoadNextBookEvent>(_onLoadMessages);
    on<AddVoteEvent>(_onAddVote);
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

  Future<void> _onAddVote(
      AddVoteEvent event, Emitter<NextBookState> emit) async {
    emit(LoadingNextBookState());
    try {
      DocumentReference bookRef =
          FirebaseFirestore.instance.collection('nextBook').doc(event.bookId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(bookRef);

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          List<dynamic> voters = data['voters'] ?? [];
          int currentVote = data['vote'] ?? 0;

          if (voters.contains(event.userId)) {
            transaction.update(bookRef, {
              'vote': currentVote > 0 ? currentVote - 1 : 0,
              'voters': FieldValue.arrayRemove([event.userId])
            });
          } else {
            transaction.update(bookRef, {
              'vote': currentVote + 1,
              'voters': FieldValue.arrayUnion([event.userId])
            });
          }
        } else {
          throw Exception("Document does not exist");
        }
      });

      QuerySnapshot updatedSnapshot =
          await FirebaseFirestore.instance.collection('nextBook').get();
      List<NextBookEntity> books =
          NextBookEntity.fromDocumentList(updatedSnapshot.docs);

      emit(SuccessNextBookState(items: books));
    } catch (e) {
      emit(FailureNextBookState(error: e.toString()));
      print("Error in voting transaction: ${e.toString()}");
    }
  }
}
