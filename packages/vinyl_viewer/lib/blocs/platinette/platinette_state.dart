part of 'platinette_bloc.dart';

abstract class PlatinetteState extends Equatable {
  const PlatinetteState();
}

class PlatinetteInitial extends PlatinetteState {
  const PlatinetteInitial();
  @override
  List<Object> get props => [];
}

class PlatinettePickingFile extends PlatinetteState {
  final Macaron macaron;
  const PlatinettePickingFile({this.macaron});
  @override
  List<Object> get props => [];
}

class PlatinetteMacaronReady extends PlatinetteState {
  final Macaron macaron;
  const PlatinetteMacaronReady(this.macaron);
  @override
  List<Object> get props => [macaron];
}

class PlatinetteRecording extends PlatinetteState {
  final Macaron macaron;
  const PlatinetteRecording(this.macaron);
  @override
  List<Object> get props => [macaron];
}

class PlatinetteError extends PlatinetteState {
  final String message;
  const PlatinetteError(this.message);
  @override
  List<Object> get props => [message];
}
