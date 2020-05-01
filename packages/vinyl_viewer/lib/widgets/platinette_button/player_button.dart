import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';

class PlayerButton extends StatefulWidget {
  final double diameter;
  final double dotDiameter;

  const PlayerButton({
    Key key,
    this.diameter,
    this.dotDiameter,
  }) : super(key: key);
  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  static const Color _color1 = Color(0xFFECF0F0);
  static TextStyle _textStyle = TextStyle(
    color: Color(0xFFF4F8F8),
    fontSize: 55,
    shadows: [
      Shadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 3,
          offset: const Offset(0, 1))
    ],
  );
  static const double _textMargin = 10;
  double _middleCircleDiameter;

  @override
  void initState() {
    assert(widget.diameter != null && widget.diameter >= 0);
    assert(widget.dotDiameter != null && widget.dotDiameter >= 0);
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
          _buildDot(),
          _buildInnerCirle(),
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
            color: _color1,
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
    double sign = i == 0 ? -1 : 1;
    return Transform.rotate(
      angle: i == 0 ? 0 : math.pi * 2 * i / 3 + math.pi,
      child: Transform.translate(
        offset: Offset(
            0,
            sign *
                ((widget.diameter / 2) -
                    (_textStyle.fontSize / 2) -
                    _textMargin +
                    3)),
        child: Text(
          text,
          style: _textStyle,
        ),
      ),
    );
  }

  Widget _buildMiddleCircle() {
    _middleCircleDiameter =
        widget.diameter - (2 * _textStyle.fontSize + 4 * _textMargin) + 2 * 9;
    return SizedBox(
      width: _middleCircleDiameter,
      height: _middleCircleDiameter,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_middleCircleDiameter)),
      ),
    );
  }

  Widget _buildInnerCirle() {
    double diameter = _middleCircleDiameter - widget.dotDiameter * 2;
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Container(
        decoration: BoxDecoration(
            color: _color1,
            borderRadius: BorderRadius.circular(diameter),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
      ),
    );
  }

  Widget _buildDot() {
    return Transform.translate(
      offset: Offset(0, -(_middleCircleDiameter / 2 - widget.dotDiameter / 2)),
      child: SizedBox(
        width: widget.dotDiameter,
        height: widget.dotDiameter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(widget.dotDiameter),
          ),
        ),
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
