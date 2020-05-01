import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/widgets/need_make_package/animated_rotation.dart';

class PlayerButton extends StatefulWidget {
  final double diameter;
  final Color color;

  const PlayerButton({
    Key key,
    this.diameter,
    this.color,
  }) : super(key: key);
  @override
  _PlayerButtonState createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<PlayerButton> {
  TextStyle _textStyle = TextStyle(
    color: Color(0xFFF4F8F8),
    fontSize: 55,
    shadows: [
      Shadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 3,
          offset: const Offset(0, 1))
    ],
  );
  double _textMargin;
  double _middleCircleDiameter;
  double _innerCircleDiameter;
  double _dotDiameter;
  double _fontSize;
  int _positionId = 0;

  @override
  void initState() {
    assert(widget.diameter != null && widget.diameter >= 0);
    assert(widget.color != null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calculeSizes();

    return BlocListener<PlayerBloc, PlayerState>(
      listener: _onPlayerStateChange,
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
    );
  }

  void _calculeSizes() {
    _middleCircleDiameter = widget.diameter * 0.583;
    _innerCircleDiameter = widget.diameter * 0.345;
    _dotDiameter = (_middleCircleDiameter - _innerCircleDiameter) / 2;
    _fontSize = 0.171 * widget.diameter;
    _textStyle = _textStyle.copyWith(fontSize: _fontSize);
    _textMargin = 0.032 * widget.diameter;
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.diameter)),
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
    return SizedBox(
      width: _innerCircleDiameter,
      height: _innerCircleDiameter,
      child: Container(
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(_innerCircleDiameter),
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
        offset: Offset(0, _middleCircleDiameter / 2 - _dotDiameter / 2),
        child: SizedBox(
          width: _dotDiameter,
          height: _dotDiameter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(_dotDiameter),
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
