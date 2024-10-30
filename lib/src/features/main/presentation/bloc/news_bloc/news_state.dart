part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class LoadingNewsState extends NewsState {}

final class FailureNewsState extends NewsState {
  final String error;

  const FailureNewsState({required this.error});

  @override
  List<Object> get props => [error];
}

final class SuccessNewsState extends NewsState {
  final List<NewsEntity> items;

  const SuccessNewsState({required this.items});

  @override
  List<Object> get props => [items];
}
