import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_bloc.freezed.dart';
part 'player_event.dart';
// part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  int _currentRpm = 33;
  int get rpm => _currentRpm;

  @override
  PlayerState get initialState => PlayerState.initial();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is Play) {
      yield* _play();
    } else if (event is Pause) {
      yield* _pause();
    } else if (event is UpdateRpm) {
      yield* _updateRpm(event.rpm);
    }
  }

  Stream<PlayerState> _play() async* {
    yield Playing(_currentRpm);
  }

  Stream<PlayerState> _pause() async* {
    yield PlayerState.paused();
  }

  Stream<PlayerState> _updateRpm(int rpm) async* {
    _currentRpm = rpm;
    if (this.state is Playing) {
      yield* _play();
    }
  }
}

@freezed
abstract class PlayerState with _$PlayerState {
  const factory PlayerState.initial() = Initial;
  const factory PlayerState.playing(int rpm) = Playing;
  const factory PlayerState.paused() = Paused;
}
