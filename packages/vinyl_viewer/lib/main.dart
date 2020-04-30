import 'package:flutter/material.dart';
import 'package:vinyl_viewer/widgets/platinette_button/player_button.dart';

import 'pages/main-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(child: MainPage()),
    );
  }
}
