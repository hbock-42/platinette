import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/theme/main_theme.dart';
import 'package:vinyl_viewer/widgets/button_bar.dart';
import 'package:vinyl_viewer/widgets/button_hover.dart';
import 'package:vinyl_viewer/widgets/platinette_button/player_button.dart';
import 'package:vinyl_viewer/widgets/recordable_rotating_macaron.dart';
import 'package:vinyl_viewer/widgets/recording_overlay.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _marginVinyl;
  double _vinylSize;
  double _leftMarginPlayerButton;
  double _playerButtonDiameter;
  double _otherButtonsDiameter;
  double _screenWidth;
  double _screenHeight;
  double _topPlayerButton;
  double _leftPlayerButton;
  bool _isPortrait;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    var minSize = math.min(_screenHeight, _screenWidth);
    _isPortrait = false;
    if (_screenWidth / _screenHeight < 3 / 4) {
      _isPortrait = true;
      _vinylSize = _screenWidth * 0.9;
      _marginVinyl = _screenHeight * 0.05;
      _leftMarginPlayerButton = _screenHeight * 0.05;
      _playerButtonDiameter = _screenHeight * 0.2;
    } else if (_screenWidth / _screenHeight < 4 / 3) {
      _vinylSize = _screenWidth * 0.65;
      _marginVinyl = _screenWidth * 0.05;
      _leftMarginPlayerButton = _screenWidth * 0.05;
      _playerButtonDiameter = _screenWidth * 0.2;
    } else {
      _vinylSize = minSize * 0.75;
      _marginVinyl = minSize * 0.2;
      _leftMarginPlayerButton = minSize * 0.1;
      _playerButtonDiameter = minSize * 0.2;
    }

    _topPlayerButton = _isPortrait
        ? _marginVinyl + _vinylSize + _leftMarginPlayerButton
        : null;
    _leftPlayerButton = _isPortrait
        ? (_screenWidth - _playerButtonDiameter) / 2
        : _marginVinyl + _vinylSize + _leftMarginPlayerButton;

    _playerButtonDiameter = math.min(_playerButtonDiameter, 200);
    _otherButtonsDiameter = _playerButtonDiameter * 0.321;

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlatinetteBloc>(
            create: (BuildContext context) => PlatinetteBloc()),
        BlocProvider<PlayerBloc>(
            create: (BuildContext context) => PlayerBloc()),
      ],
      // child: Container(),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          _buildVinyl(),
          _buildPlayerButton(),
          ..._buildOtherButtons(),
        ],
      ),
      //   child: BlocBuilder<PlatinetteBloc, PlatinetteState>(
      //     builder: (BuildContext context, PlatinetteState state) {
      //       return Stack(
      //         children: [
      //           Container(
      //             color: state is PlatinetteMacaronReady
      //                 ? state.macaron.mainColor
      //                 : state is PlatinetteRecording
      //                     ? state.macaron.mainColor
      //                     : state is PlatinettePickingFile &&
      //                             state.macaron != null
      //                         ? state.macaron.mainColor
      //                         : Colors.blue,
      //             child: IntrinsicHeight(
      //               child: Column(
      //                 children: [
      //                   buildButtonBar(context, state),
      //                   Expanded(
      //                     child: AspectRatio(
      //                       aspectRatio: 1,
      //                       child: RecordableRotatingMacaron(),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           if (state is PlatinettePickingFile)
      //             Container(color: Colors.grey.withOpacity(0.4)),
      //           if (state is PlatinetteRecording) RecordingOverlay(),
      //         ],
      //       );
      //     },
      //   ),
    );
  }

  Widget buildButtonBar(BuildContext context, PlatinetteState state) {
    var platinetteBloc = context.bloc<PlatinetteBloc>();
    return Wrap(
      spacing: 0,
      runSpacing: 10,
      // return Row(
      children: [
        NeumorphicButton(
          child: Text("Get a macaron"),
          onClick: () => platinetteBloc.add(GetMacaron()),
        ),
        if (state is PlatinetteMacaronReady)
          Row(
            children: [
              SizedBox(width: 15),
              PlayerButtonBar(),
              SizedBox(width: 15),
              ButtonHover(
                'start record',
                onClick: () => platinetteBloc.add(Record()),
              ),
            ],
          )
      ],
    );
  }

  Widget _buildVinyl() {
    return Positioned(
      top: _isPortrait ? _marginVinyl : null,
      left: _isPortrait ? _screenWidth * 0.05 : _marginVinyl,
      child: UnconstrainedBox(
        child: LimitedBox(
          maxWidth: _vinylSize,
          maxHeight: _vinylSize,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerButton() {
    return Positioned(
      top: _topPlayerButton,
      left: _leftPlayerButton,
      child: UnconstrainedBox(
        child: LimitedBox(
          maxHeight: 200,
          maxWidth: 200,
          child: Neumorphic(
              boxShape: NeumorphicBoxShape.roundRect(
                  borderRadius: BorderRadius.circular(_playerButtonDiameter)),
              style: AppTheme.neumorphic,
              child: PlayerButton(
                  diameter: _playerButtonDiameter, color: AppTheme.whiteFake)),
        ),
      ),
    );
  }

  List<Widget> _buildOtherButtons() {
    var _buttons = List<Widget>();
    _buttons.add(Positioned(
      top: _topPlayerButton != null
          ? _topPlayerButton + _playerButtonDiameter / 2
          : _screenHeight / 2 -
              (_otherButtonsDiameter + _playerButtonDiameter / 2 + 28),
      left: !_isPortrait
          ? _leftPlayerButton - _otherButtonsDiameter / 2
          : _leftPlayerButton - _otherButtonsDiameter - 20,
      child: Container(
        width: _otherButtonsDiameter,
        height: _otherButtonsDiameter,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(_playerButtonDiameter)),
          style: AppTheme.neumorphic,
        ),
      ),
    ));

    _buttons.add(Positioned(
      top: _topPlayerButton != null
          ? _topPlayerButton + _playerButtonDiameter / 2
          : _screenHeight / 2 + (_playerButtonDiameter / 2 + 28),
      left: !_isPortrait
          ? _leftPlayerButton - _otherButtonsDiameter / 2
          : _leftPlayerButton + _playerButtonDiameter + 20,
      child: Container(
        width: _otherButtonsDiameter,
        height: _otherButtonsDiameter,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(_playerButtonDiameter)),
          style: AppTheme.neumorphic,
        ),
      ),
    ));
    return _buttons;
  }
}
