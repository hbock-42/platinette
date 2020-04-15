// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'macaron.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$MacaronTearOff {
  const _$MacaronTearOff();

  _Macaron call(
      {@required File file,
      @required String path,
      @required Color mainColor,
      List<Image> frames}) {
    return _Macaron(
      file: file,
      path: path,
      mainColor: mainColor,
      frames: frames,
    );
  }
}

// ignore: unused_element
const $Macaron = _$MacaronTearOff();

mixin _$Macaron {
  File get file;
  String get path;
  Color get mainColor;
  List<Image> get frames;

  $MacaronCopyWith<Macaron> get copyWith;
}

abstract class $MacaronCopyWith<$Res> {
  factory $MacaronCopyWith(Macaron value, $Res Function(Macaron) then) =
      _$MacaronCopyWithImpl<$Res>;
  $Res call({File file, String path, Color mainColor, List<Image> frames});
}

class _$MacaronCopyWithImpl<$Res> implements $MacaronCopyWith<$Res> {
  _$MacaronCopyWithImpl(this._value, this._then);

  final Macaron _value;
  // ignore: unused_field
  final $Res Function(Macaron) _then;

  @override
  $Res call({
    Object file = freezed,
    Object path = freezed,
    Object mainColor = freezed,
    Object frames = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed ? _value.file : file as File,
      path: path == freezed ? _value.path : path as String,
      mainColor: mainColor == freezed ? _value.mainColor : mainColor as Color,
      frames: frames == freezed ? _value.frames : frames as List<Image>,
    ));
  }
}

abstract class _$MacaronCopyWith<$Res> implements $MacaronCopyWith<$Res> {
  factory _$MacaronCopyWith(_Macaron value, $Res Function(_Macaron) then) =
      __$MacaronCopyWithImpl<$Res>;
  @override
  $Res call({File file, String path, Color mainColor, List<Image> frames});
}

class __$MacaronCopyWithImpl<$Res> extends _$MacaronCopyWithImpl<$Res>
    implements _$MacaronCopyWith<$Res> {
  __$MacaronCopyWithImpl(_Macaron _value, $Res Function(_Macaron) _then)
      : super(_value, (v) => _then(v as _Macaron));

  @override
  _Macaron get _value => super._value as _Macaron;

  @override
  $Res call({
    Object file = freezed,
    Object path = freezed,
    Object mainColor = freezed,
    Object frames = freezed,
  }) {
    return _then(_Macaron(
      file: file == freezed ? _value.file : file as File,
      path: path == freezed ? _value.path : path as String,
      mainColor: mainColor == freezed ? _value.mainColor : mainColor as Color,
      frames: frames == freezed ? _value.frames : frames as List<Image>,
    ));
  }
}

class _$_Macaron with DiagnosticableTreeMixin implements _Macaron {
  const _$_Macaron(
      {@required this.file,
      @required this.path,
      @required this.mainColor,
      this.frames})
      : assert(file != null),
        assert(path != null),
        assert(mainColor != null);

  @override
  final File file;
  @override
  final String path;
  @override
  final Color mainColor;
  @override
  final List<Image> frames;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Macaron(file: $file, path: $path, mainColor: $mainColor, frames: $frames)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Macaron'))
      ..add(DiagnosticsProperty('file', file))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('mainColor', mainColor))
      ..add(DiagnosticsProperty('frames', frames));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Macaron &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.mainColor, mainColor) ||
                const DeepCollectionEquality()
                    .equals(other.mainColor, mainColor)) &&
            (identical(other.frames, frames) ||
                const DeepCollectionEquality().equals(other.frames, frames)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(mainColor) ^
      const DeepCollectionEquality().hash(frames);

  @override
  _$MacaronCopyWith<_Macaron> get copyWith =>
      __$MacaronCopyWithImpl<_Macaron>(this, _$identity);
}

abstract class _Macaron implements Macaron {
  const factory _Macaron(
      {@required File file,
      @required String path,
      @required Color mainColor,
      List<Image> frames}) = _$_Macaron;

  @override
  File get file;
  @override
  String get path;
  @override
  Color get mainColor;
  @override
  List<Image> get frames;
  @override
  _$MacaronCopyWith<_Macaron> get copyWith;
}
