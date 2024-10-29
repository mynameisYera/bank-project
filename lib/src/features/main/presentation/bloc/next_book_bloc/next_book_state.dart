part of 'next_book_bloc.dart';

sealed class NextBookState extends Equatable {
  const NextBookState();

  @override
  List<Object> get props => [];
}

final class LoadingNextBookState extends NextBookState {}

final class FailureNextBookState extends NextBookState {
  final String error;

  const FailureNextBookState({required this.error});

  @override
  List<Object> get props => [error];
}

final class SuccessNextBookState extends NextBookState {
  final List<NextBookEntity> items;

  const SuccessNextBookState({required this.items});

  @override
  List<Object> get props => [items];
}
