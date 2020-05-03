import 'package:flutter/material.dart';

import 'player_button.dart';

class AnimatedPlayerButton extends StatefulWidget {
  final Duration duration;
  final Curve diameterCurve;
  final Curve colorCurve;
  final double diameter;
  final Color color;

  const AnimatedPlayerButton({
    Key key,
    @required this.duration,
    @required this.diameter,
    @required this.color,
    this.diameterCurve = Curves.linear,
    this.colorCurve = Curves.linear,
  }) : super(key: key);

  @override
  _AnimatedPlayerButtonState createState() => _AnimatedPlayerButtonState();
}

class _AnimatedPlayerButtonState extends State<AnimatedPlayerButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Curve _diameterCurve;
  Curve _colorCurve;
  Animation _diameterAnimation;
  Animation _colorAnimation;

  @override
  void initState() {
    super.initState();

    assert(widget.duration != null);
    assert(widget.diameter != null && widget.diameter >= 0);
    assert(widget.color != null);
    if (widget.diameterCurve == null) {
      _diameterCurve = Curves.linear;
    } else {
      _diameterCurve = widget.diameterCurve;
    }
    if (widget.colorCurve == null) {
      _colorCurve = Curves.linear;
    } else {
      _colorCurve = widget.colorCurve;
    }

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _diameterAnimation = Tween(begin: widget.diameter, end: widget.diameter)
        .animate(_controller);
    _colorAnimation =
        Tween(begin: widget.color, end: widget.color).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedPlayerButton oldWidget) {
    if (oldWidget.diameter != widget.diameter ||
        oldWidget.color != widget.color) {
      if (oldWidget.diameter != widget.diameter) {
        _diameterAnimation =
            Tween(begin: oldWidget.diameter, end: widget.diameter).animate(
                CurvedAnimation(parent: _controller, curve: _diameterCurve));
      }
      if (oldWidget.color != widget.color) {
        _colorAnimation = Tween(begin: oldWidget.color, end: widget.color)
            .animate(CurvedAnimation(parent: _controller, curve: _colorCurve));
      }
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return PlayerButton(
          diameter: _diameterAnimation.value,
          color: _colorAnimation.value,
        );
      },
    );
  }
}
