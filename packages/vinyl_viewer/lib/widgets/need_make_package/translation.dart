import 'package:flutter/material.dart';

class Translation extends StatelessWidget {
  final Widget child;
  final Offset offset;

  const Translation({Key key, this.child, this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finalOffset = offset != null ? offset : Offset.zero;
    return Transform.translate(offset: finalOffset, child: child);
  }
}
