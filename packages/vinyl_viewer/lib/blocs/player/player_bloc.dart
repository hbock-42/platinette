import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  int _currentRpm = 33;
  int get rpm => _currentRpm;

  @override
  PlayerState get initialState => PlayerInitial();

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
    yield PlayerPlaying(_currentRpm);
  }

  Stream<PlayerState> _pause() async* {
    yield PlayerPaused();
  }

  Stream<PlayerState> _updateRpm(int rpm) async* {
    _currentRpm = rpm;
    print("in update");
    if (this.state is PlayerPlaying) {
      yield* _play();
    }
  }
}
