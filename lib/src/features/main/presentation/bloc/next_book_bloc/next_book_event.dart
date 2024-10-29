part of 'next_book_bloc.dart';

sealed class NextBookEvent extends Equatable {
  const NextBookEvent();

  @override
  List<Object> get props => [];
}

class LoadNextBookEvent extends NextBookEvent {}
