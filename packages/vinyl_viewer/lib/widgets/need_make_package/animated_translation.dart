import 'package:flutter/material.dart';

import 'translation.dart';

class AnimatedTranslation extends StatefulWidget {
  final Duration duration;
  final Offset offset;
  final Widget child;
  final Curve curve;

  const AnimatedTranslation({
    Key key,
    @required this.duration,
    @required this.offset,
    @required this.child,
    this.curve,
  }) : super(key: key);

  @override
  _AnimatedTranslationState createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState extends State<AnimatedTranslation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _offsetAnimation;
  Curve _curve;

  @override
  void initState() {
    if (widget.curve == null) {
      _curve = Curves.linear;
    } else {
      _curve = widget.curve;
    }
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _offsetAnimation =
        Tween(begin: widget.offset, end: widget.offset).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedTranslation oldWidget) {
    if (oldWidget.offset != widget.offset) {
      _offsetAnimation = Tween(begin: oldWidget.offset, end: widget.offset)
          .animate(CurvedAnimation(parent: _controller, curve: _curve));
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Translation(
          offset: _offsetAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
