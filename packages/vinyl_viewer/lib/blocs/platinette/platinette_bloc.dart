import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vinyl_viewer/helpers/image_main_color.dart';
import 'package:vinyl_viewer/models/macaron.dart';

import 'package:file_chooser/file_chooser.dart';

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
      var fileChooserResult = await showOpenPanel();
      if (fileChooserResult.canceled) {
        yield PlatinetteInitial();
      } else {
        var macaronFile = File(fileChooserResult.paths.first);
        var color = mainColorFromBytes(await macaronFile.readAsBytes());
        _macaron = Macaron(
          path: macaronFile.path,
          mainColor: color,
          file: macaronFile,
        );
        yield PlatinetteMacaronReady(_macaron);
      }
    } catch (ex) {
      yield PlatinetteError("Error while picking a file");
    }
  }

  Stream<PlatinetteState> _record() async* {
    yield PlatinetteRecording(_macaron);
  }
}
