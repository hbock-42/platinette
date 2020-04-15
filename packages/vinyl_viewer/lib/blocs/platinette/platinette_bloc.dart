import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vinyl_viewer/helpers/image_main_color.dart';
import 'package:vinyl_viewer/models/macaron.dart';

part 'platinette_event.dart';
part 'platinette_state.dart';

class PlatinetteBloc extends Bloc<PlatinetteEvent, PlatinetteState> {
  Macaron _macaron;

  @override
  PlatinetteState get initialState => PlatinetteInitial();

  @override
  Stream<PlatinetteState> mapEventToState(
    PlatinetteEvent event,
  ) async* {
    if (event is GetMacaron) {
      yield* _getMacaron();
    } else if (event is Record) {
      yield* _record();
    }
  }

  Stream<PlatinetteState> _getMacaron() async* {
    try {
      yield PlatinettePickingFile();
      var macaronFile = await FilePicker.getFile(type: FileType.image);
      if (macaronFile != null) {
        var color = mainColorFromBytes(await macaronFile.readAsBytes());
        _macaron = Macaron(
          path: macaronFile.path,
          mainColor: color,
          file: macaronFile,
        );
        yield PlatinetteMacaronReady(_macaron);
      } else {
        yield PlatinetteInitial();
      }
    } catch (ex) {
      yield PlatinetteError("Error while picking a file");
    }
  }

  Stream<PlatinetteState> _record() async* {
    yield PlatinetteRecording(_macaron);
  }
}
