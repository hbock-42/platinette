import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';

class PlayerButton extends StatefulWidget {
  final double diameter;

  const PlayerButton({Key key, this.diameter}) : super(key: key);
  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  static const TextStyle _textStyle =
      TextStyle(color: Colors.white, fontSize: 50);
  static const double _textMargin = 15;

  @override
  void initState() {
    assert(widget.diameter != null && widget.diameter >= 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: _onPlayerStateChange,
      child: Container(
        color: Colors.red,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          _buildBackground(),
          ..._buildTexts(),
          _buildMiddleCircle(),
        ]),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: widget.diameter,
      height: widget.diameter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(widget.diameter)),
      ),
    );
  }

  List<Widget> _buildTexts() {
    var texts = List<Widget>();
    texts.add(_buildText("33", 0));
    texts.add(_buildText("45", 1));
    texts.add(_buildText("78", 2));
    return texts;
  }

  Widget _buildText(String text, int i) {
    return Transform.rotate(
      angle: math.pi * 2 * i / 3,
      child: Transform.translate(
        offset: Offset(
            0,
            (widget.diameter / 2) -
                (_textStyle.fontSize / 2) -
                _textMargin +
                3),
        child: Text(
          text,
          style: _textStyle,
        ),
      ),
    );
  }

  Widget _buildMiddleCircle() {
    double diameter =
        widget.diameter - (2 * _textStyle.fontSize + 4 * _textMargin) + 2 * 9;
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.diameter)),
      ),
    );
  }

  void _onPlayerStateChange(BuildContext context, PlayerState state) {
    state.when(
      initial: () => {},
      playing: (rpm) => {},
      paused: () => {},
    );
  }
}
