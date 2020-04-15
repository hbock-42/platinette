import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui';

part 'macaron.freezed.dart';

@freezed
abstract class Macaron with _$Macaron {
  const factory Macaron({
    @required File file,
    @required String path,
    @required Color mainColor,
    List<Image> frames,
  }) = _Macaron;
}
