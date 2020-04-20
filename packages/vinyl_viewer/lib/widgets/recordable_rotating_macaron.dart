import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/helpers/recorder_infos.dart';
import 'package:vinyl_viewer/helpers/save_widget_as_png.dart';
import 'package:vinyl_viewer/models/macaron.dart';
import 'package:image/image.dart' as img;
import 'package:file_chooser/file_chooser.dart';

class RecordableRotatingMacaron extends StatefulWidget {
  @override
  _RecordableRotatingMacaronState createState() =>
      _RecordableRotatingMacaronState();
}

class _RecordableRotatingMacaronState extends State<RecordableRotatingMacaron>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey _macaronWidgetKey = GlobalKey();
  PlayerState _prerecordPlayerState;
  RecorderInfo _recorderInfo;
  List<img.Image> _frameImages;

  int get recordedFrameCount => _frameImages == null ? 0 : _frameImages.length;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PlayerBloc, PlayerState>(
          listener: (context, state) {
            var playerBloc = context.bloc<PlayerBloc>();
            if (state is PlayerPlaying) {
              _controller.duration = _animationDurationFromRpm(playerBloc.rpm);
              _controller.repeat();
            } else if (state is PlayerPaused) {
              _controller.stop(canceled: false);
            }
          },
        ),
        BlocListener<PlatinetteBloc, PlatinetteState>(
          listener: (context, state) {
            if (state is PlatinetteRecording) {
              _initializeRecording();
            }
          },
        )
      ],
      child: BlocBuilder<PlatinetteBloc, PlatinetteState>(
        builder: (BuildContext context, PlatinetteState state) {
          if (state is PlatinetteInitial)
            return Container(color: Colors.orange);
          if (state is PlatinettePickingFile && state.macaron != null) {
            return buildMacaron(context, state.macaron);
          }
          if (state is PlatinetteMacaronReady) {
            return buildMacaron(context, state.macaron);
          }
          if (state is PlatinetteRecording) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _saveFrameImage(Duration(
                      milliseconds:
                          _recorderInfo.frameDurationsInMs[recordedFrameCount]))
                  .then(
                (newFrame) => {
                  _frameImages.add(newFrame),
                  if (recordedFrameCount >= _recorderInfo.frameRequested)
                    {
                      _saveAnimation().then(
                        (value) => {
                          if (_prerecordPlayerState is PlayerPlaying)
                            {
                              _controller.repeat(),
                            },
                          context.bloc<PlatinetteBloc>().add(RecordEnded()),
                        },
                      ),
                    }
                  else
                    {
                      setState(() {
                        _controller.value =
                            recordedFrameCount / _recorderInfo.frameRequested;
                      }),
                    }
                },
              );
            });
            return buildMacaron(context, state.macaron);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildMacaron(BuildContext context, Macaron macaron) {
    return RepaintBoundary(
      key: _macaronWidgetKey,
      child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: 2.0 * math.pi * _controller.value,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: FileImage(macaron.file), fit: BoxFit.fill),
                ),
              ),
            );
          }),
    );
  }

  Duration _animationDurationFromRpm(int rpm) {
    return Duration(milliseconds: (60 / rpm * 1000).round());
  }

  void _initializeRecording() {
    _prerecordPlayerState = context.bloc<PlayerBloc>().state;
    _controller.reset();
    _recorderInfo =
        RecorderInfo(Fps.Fps50, _controller.duration.inMilliseconds);
    _frameImages = List<img.Image>();
  }

  Future<img.Image> _saveFrameImage(Duration frameDuration) async {
    List<int> encodedPng =
        await saveWidgetAsPng(_macaronWidgetKey, pixelRatio: 0.5);
    img.Image decodedImage = img.decodeImage(encodedPng)
      ..duration = frameDuration.inMilliseconds;
    decodedImage.blendMethod = img.BlendMode.source;
    return decodedImage;
  }

  Future _saveAnimation() async {
    FileChooserResult result;
    do {
      result = await showSavePanel(allowedFileTypes: [
        FileTypeFilterGroup(fileExtensions: ["png"])
      ]);
      if (result.canceled) {
        // Todo: popup asking if it is ok to loose animation
        print("The animation will be loosed");
      }
    } while (result.canceled);
    if (!result.canceled) {
      var animation = img.Animation();
      animation.backgroundColor = 0;
      int maxWidth = 0;
      int maxHeight = 0;
      _frameImages.forEach((image) => {
            animation.addFrame(image),
            if (image.width > maxWidth) {maxWidth = image.width},
            if (image.height > maxHeight) {maxHeight = image.height},
          });
      animation.width = maxWidth;
      animation.height = maxHeight;
      List<int> encodedAnimation = img.encodePngAnimation(animation);
      File(result.paths.first)..writeAsBytesSync(encodedAnimation);
    }
  }
}
