import 'dart:async';

import 'package:flutter/material.dart';

class RecordingOverlay extends StatefulWidget {
  @override
  _RecordingOverlayState createState() => _RecordingOverlayState();
}

class _RecordingOverlayState extends State<RecordingOverlay> {
  static const List<String> dots = ["", ".", "..", "..."];
  Timer _timer;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(milliseconds: 800),
      (timer) => setState(
        () {
          index++;
          if (index >= dots.length) {
            index = 0;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.8),
      child: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Wrap(children: [
              Text("Work in progress"),
              SizedBox(width: 20, child: Text(dots[index])),
            ])),
      ),
    );
  }
}
