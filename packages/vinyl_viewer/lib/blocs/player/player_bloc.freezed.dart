// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PlayerStateTearOff {
  const _$PlayerStateTearOff();

  Initial initial([int rpm = PlayerBloc.InitialRpm]) {
    return Initial(
      rpm,
    );
  }

  Playing playing(int rpm) {
    return Playing(
      rpm,
    );
  }

  Paused paused(int rpm) {
    return Paused(
      rpm,
    );
  }
}

// ignore: unused_element
const $PlayerState = _$PlayerStateTearOff();

mixin _$PlayerState {
  int get rpm;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(int rpm),
    @required Result playing(int rpm),
    @required Result paused(int rpm),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(int rpm),
    Result playing(int rpm),
    Result paused(int rpm),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result playing(Playing value),
    @required Result paused(Paused value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result playing(Playing value),
    Result paused(Paused value),
    @required Result orElse(),
  });

  $PlayerStateCopyWith<PlayerState> get copyWith;
}

abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
          PlayerState value, $Res Function(PlayerState) then) =
      _$PlayerStateCopyWithImpl<$Res>;
  $Res call({int rpm});
}

class _$PlayerStateCopyWithImpl<$Res> implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  final PlayerState _value;
  // ignore: unused_field
  final $Res Function(PlayerState) _then;

  @override
  $Res call({
    Object rpm = freezed,
  }) {
    return _then(_value.copyWith(
      rpm: rpm == freezed ? _value.rpm : rpm as int,
    ));
  }
}

abstract class $InitialCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
  @override
  $Res call({int rpm});
}

class _$InitialCopyWithImpl<$Res> extends _$PlayerStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;

  @override
  $Res call({
    Object rpm = freezed,
  }) {
    return _then(Initial(
      rpm == freezed ? _value.rpm : rpm as int,
    ));
  }
}

class _$Initial implements Initial {
  const _$Initial([this.rpm = PlayerBloc.InitialRpm]) : assert(rpm != null);

  @JsonKey(defaultValue: PlayerBloc.InitialRpm)
  @override
  final int rpm;

  @override
  String toString() {
    return 'PlayerState.initial(rpm: $rpm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Initial &&
            (identical(other.rpm, rpm) ||
                const DeepCollectionEquality().equals(other.rpm, rpm)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rpm);

  @override
  $InitialCopyWith<Initial> get copyWith =>
      _$InitialCopyWithImpl<Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(int rpm),
    @required Result playing(int rpm),
    @required Result paused(int rpm),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return initial(rpm);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(int rpm),
    Result playing(int rpm),
    Result paused(int rpm),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(rpm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result playing(Playing value),
    @required Result paused(Paused value),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result playing(Playing value),
    Result paused(Paused value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements PlayerState {
  const factory Initial([int rpm]) = _$Initial;

  @override
  int get rpm;
  @override
  $InitialCopyWith<Initial> get copyWith;
}

abstract class $PlayingCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PlayingCopyWith(Playing value, $Res Function(Playing) then) =
      _$PlayingCopyWithImpl<$Res>;
  @override
  $Res call({int rpm});
}

class _$PlayingCopyWithImpl<$Res> extends _$PlayerStateCopyWithImpl<$Res>
    implements $PlayingCopyWith<$Res> {
  _$PlayingCopyWithImpl(Playing _value, $Res Function(Playing) _then)
      : super(_value, (v) => _then(v as Playing));

  @override
  Playing get _value => super._value as Playing;

  @override
  $Res call({
    Object rpm = freezed,
  }) {
    return _then(Playing(
      rpm == freezed ? _value.rpm : rpm as int,
    ));
  }
}

class _$Playing implements Playing {
  const _$Playing(this.rpm) : assert(rpm != null);

  @override
  final int rpm;

  @override
  String toString() {
    return 'PlayerState.playing(rpm: $rpm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Playing &&
            (identical(other.rpm, rpm) ||
                const DeepCollectionEquality().equals(other.rpm, rpm)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rpm);

  @override
  $PlayingCopyWith<Playing> get copyWith =>
      _$PlayingCopyWithImpl<Playing>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(int rpm),
    @required Result playing(int rpm),
    @required Result paused(int rpm),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return playing(rpm);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(int rpm),
    Result playing(int rpm),
    Result paused(int rpm),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playing != null) {
      return playing(rpm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result playing(Playing value),
    @required Result paused(Paused value),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return playing(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result playing(Playing value),
    Result paused(Paused value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class Playing implements PlayerState {
  const factory Playing(int rpm) = _$Playing;

  @override
  int get rpm;
  @override
  $PlayingCopyWith<Playing> get copyWith;
}

abstract class $PausedCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory $PausedCopyWith(Paused value, $Res Function(Paused) then) =
      _$PausedCopyWithImpl<$Res>;
  @override
  $Res call({int rpm});
}

class _$PausedCopyWithImpl<$Res> extends _$PlayerStateCopyWithImpl<$Res>
    implements $PausedCopyWith<$Res> {
  _$PausedCopyWithImpl(Paused _value, $Res Function(Paused) _then)
      : super(_value, (v) => _then(v as Paused));

  @override
  Paused get _value => super._value as Paused;

  @override
  $Res call({
    Object rpm = freezed,
  }) {
    return _then(Paused(
      rpm == freezed ? _value.rpm : rpm as int,
    ));
  }
}

class _$Paused implements Paused {
  const _$Paused(this.rpm) : assert(rpm != null);

  @override
  final int rpm;

  @override
  String toString() {
    return 'PlayerState.paused(rpm: $rpm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Paused &&
            (identical(other.rpm, rpm) ||
                const DeepCollectionEquality().equals(other.rpm, rpm)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rpm);

  @override
  $PausedCopyWith<Paused> get copyWith =>
      _$PausedCopyWithImpl<Paused>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(int rpm),
    @required Result playing(int rpm),
    @required Result paused(int rpm),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return paused(rpm);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(int rpm),
    Result playing(int rpm),
    Result paused(int rpm),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (paused != null) {
      return paused(rpm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(Initial value),
    @required Result playing(Playing value),
    @required Result paused(Paused value),
  }) {
    assert(initial != null);
    assert(playing != null);
    assert(paused != null);
    return paused(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(Initial value),
    Result playing(Playing value),
    Result paused(Paused value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class Paused implements PlayerState {
  const factory Paused(int rpm) = _$Paused;

  @override
  int get rpm;
  @override
  $PausedCopyWith<Paused> get copyWith;
}
