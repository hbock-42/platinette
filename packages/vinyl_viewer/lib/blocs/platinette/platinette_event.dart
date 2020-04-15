part of 'platinette_bloc.dart';

abstract class PlatinetteEvent extends Equatable {
  const PlatinetteEvent();
}

class GetMacaron extends PlatinetteEvent {
  @override
  List<Object> get props => [];
}

class Record extends PlatinetteEvent {
  @override
  List<Object> get props => [];
}
