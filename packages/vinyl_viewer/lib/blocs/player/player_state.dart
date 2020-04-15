part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerPlaying extends PlayerState {
  final int rpm;
  const PlayerPlaying(this.rpm);
  @override
  List<Object> get props => [rpm];
}

class PlayerPaused extends PlayerState {
  const PlayerPaused();
  @override
  List<Object> get props => [];
}
