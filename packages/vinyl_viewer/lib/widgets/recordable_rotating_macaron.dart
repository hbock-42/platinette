import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/models/macaron.dart';

class RecordableRotatingMacaron extends StatefulWidget {
  @override
  _RecordableRotatingMacaronState createState() =>
      _RecordableRotatingMacaronState();
}

class _RecordableRotatingMacaronState extends State<RecordableRotatingMacaron>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey _macaronWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        var playerBloc = context.bloc<PlayerBloc>();
        if (state is PlayerPlaying) {
          print("in Play");
          _controller.duration =
              Duration(milliseconds: (60 / playerBloc.rpm * 1000).round());
          _controller.repeat();
        } else if (state is PlayerPaused) {
          print("in Pause");
          _controller.stop(canceled: false);
        }
      },
      child: BlocBuilder<PlatinetteBloc, PlatinetteState>(
        builder: (BuildContext context, PlatinetteState state) {
          if (state is PlatinetteInitial)
            return Container(color: Colors.orange);
          if (state is PlatinetteMacaronReady) {
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
}
