part of 'next_book_bloc.dart';

sealed class NextBookEvent extends Equatable {
  const NextBookEvent();

  @override
  List<Object> get props => [];
}

class LoadNextBookEvent extends NextBookEvent {}

class AddVoteEvent extends NextBookEvent {
  final String bookId;
  final String userId;

  const AddVoteEvent(this.bookId, this.userId);

  @override
  List<Object> get props => [bookId, userId];
}
