import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/widgets/need_make_package/animated_rotation.dart';

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
  int _positionId = 0;

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
        child: UnconstrainedBox(
          child: LimitedBox(
            maxWidth: widget.diameter,
            maxHeight: widget.diameter,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              _buildBackground(),
              _buildMiddleCircle(),
              _buildDot(),
              _buildInnerCirle(),
              ..._buildTexts(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
          color: _color1, borderRadius: BorderRadius.circular(widget.diameter)),
    );
  }

  List<Widget> _buildTexts() {
    var playerBloc = context.bloc<PlayerBloc>();
    var texts = List<Widget>();
    texts.add(_buildText("33", 0, () => playerBloc.add(UpdateRpm(33))));
    texts.add(_buildText("45", 1, () => playerBloc.add(UpdateRpm(45))));
    texts.add(_buildText("78", 2, () => playerBloc.add(UpdateRpm(78))));
    return texts;
  }

  Widget _buildText(String text, int i, void Function() onPointerUp) {
    return Transform.rotate(
      angle: _getRotationNumbers(i),
      child: Transform.translate(
        offset: _getTranslation(
            i,
            (widget.diameter / 2) -
                (_textStyle.fontSize / 2) -
                _textMargin +
                3),
        child: Listener(
          onPointerUp: (_) => onPointerUp(),
          child: Text(
            text,
            style: _textStyle,
          ),
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
    return AnimatedRotation(
      curve: Curves.elasticOut,
      duration: Duration(milliseconds: 1500),
      angle: math.pi * 2 * _positionId / 3 + math.pi,
      child: Transform.translate(
        offset: Offset(0, _middleCircleDiameter / 2 - widget.dotDiameter / 2),
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
      ),
    );
  }

  double _getRotationNumbers(int positionId) {
    return positionId == 0 ? 0 : math.pi * 2 * positionId / 3 + math.pi;
  }

  Offset _getTranslation(int positionId, double distance) {
    double sign = positionId == 0 ? -1 : 1;
    return Offset(0, sign * distance);
  }

  void _onPlayerStateChange(BuildContext context, PlayerState state) {
    state.when(
      initial: (rpm) => {setState(() => _mapRpmToPositions(rpm))},
      playing: (rpm) => {setState(() => _mapRpmToPositions(rpm))},
      paused: () => {},
    );
  }

  void _mapRpmToPositions(int rpm) {
    if (rpm == 33) {
      _positionId = 0;
    } else if (rpm == 45) {
      _positionId = 1;
    } else if (rpm == 78) {
      _positionId = 2;
    }
  }
}
