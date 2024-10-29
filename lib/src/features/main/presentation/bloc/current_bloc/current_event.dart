part of 'current_bloc.dart';

sealed class CurrentEvent extends Equatable {
  const CurrentEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentEvent extends CurrentEvent {}
