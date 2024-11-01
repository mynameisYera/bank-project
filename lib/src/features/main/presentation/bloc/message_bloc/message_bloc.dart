import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:bank/src/features/main/domain/messages_entity.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(LoadingMessageState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
  }

  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<MessageState> emit) async {
    emit(LoadingMessageState());
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('chat').get();
      List<MessageEntity> messages =
          MessageEntity.fromDocumentList(snapshot.docs);
      emit(SuccessMessageState(items: messages));
    } catch (e) {
      emit(FailureMessageState(error: e.toString()));
    }
  }
}
