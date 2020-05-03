import 'package:flutter/material.dart';

import 'player_button.dart';

class AnimatedPlayerButton extends StatefulWidget {
  final Duration duration;
  final Curve diameterCurve;
  final double diameter;
  final Color color;

  const AnimatedPlayerButton({
    Key key,
    @required this.duration,
    @required this.diameter,
    @required this.color,
    this.diameterCurve = Curves.linear,
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
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _diameterAnimation = Tween(begin: widget.diameter, end: widget.diameter)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedPlayerButton oldWidget) {
    if (oldWidget.diameter != widget.diameter) {
      _diameterAnimation = Tween(
              begin: oldWidget.diameter, end: widget.diameter)
          .animate(CurvedAnimation(parent: _controller, curve: _diameterCurve));
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
          color: widget.color,
        );
      },
    );
  }
}
