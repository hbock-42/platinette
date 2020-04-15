part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
}

class Play extends PlayerEvent {
  const Play();
  @override
  List<Object> get props => [];
}

class Pause extends PlayerEvent {
  const Pause();
  @override
  List<Object> get props => [];
}

class UpdateRpm extends PlayerEvent {
  final int rpm;
  const UpdateRpm(this.rpm);
  @override
  List<Object> get props => [];
}
