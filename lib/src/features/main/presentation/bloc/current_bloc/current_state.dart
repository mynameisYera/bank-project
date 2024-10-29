part of 'current_bloc.dart';

sealed class CurrentState extends Equatable {
  const CurrentState();

  @override
  List<Object> get props => [];
}

final class LoadingCurrentState extends CurrentState {}

final class FailureCurrentState extends CurrentState {
  final String error;

  const FailureCurrentState({required this.error});

  @override
  List<Object> get props => [error];
}

final class SuccessCurrentState extends CurrentState {
  final List<CurrentEntity> items;

  const SuccessCurrentState({required this.items});

  @override
  List<Object> get props => [items];
}
