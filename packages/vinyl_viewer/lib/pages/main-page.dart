import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/theme/main_theme.dart';
import 'package:vinyl_viewer/widgets/button_bar.dart';
import 'package:vinyl_viewer/widgets/button_hover.dart';
import 'package:vinyl_viewer/widgets/platinette_button/animated_player_button.dart';
import 'package:vinyl_viewer/widgets/platinette_button/player_button.dart';
import 'package:vinyl_viewer/widgets/recordable_rotating_macaron.dart';
import 'package:vinyl_viewer/widgets/recording_overlay.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Duration _animationDuration = Duration(milliseconds: 300);
  Curve _animationCurve = Curves.easeIn;
  // double _marginVinyl;
  // double _vinylSize;
  // double _leftMarginPlayerButton;
  // double _playerButtonDiameter;
  // double _otherButtonsDiameter;
  // double _topPlayerButton;
  // double _leftPlayerButton;

  // bool _isMobile;
  // double _distanceLittleButtonsToPlayerButton;

  double _screenWidth;
  double _screenHeight;
  bool _isPlaying = false;

  double _marginLeftVinyl;
  double _marginTopVinyl;
  double _vinylSize;

  double _marginLeftPlayerButton;
  double _marginTopPlayerButton;
  double _playerButtonSize;

  double _littleButtonSize;
  double _littleButtonsVerticalDistance;
  double _littleButtonsHorizontalDistance;

  // vinyl
  double get _rigthVinyl => _isMobile ? null : _marginLeftVinyl + _vinylSize;
  double get _topVinyl => _isMobile ? _marginTopVinyl : null;
  double get _bottomVinyl => _isMobile ? _marginTopVinyl + _vinylSize : null;
  double get _leftVinyl => _isMobile ? null : _marginLeftVinyl;
  double get _maxVinylSizeOnPlayMobile => _screenWidth * 1.5;

  // player
  double get _leftPlayerButton =>
      _isMobile ? null : _rigthVinyl + _marginLeftPlayerButton;
  double get _topPlayerButton =>
      _isMobile ? _bottomVinyl + _marginTopPlayerButton : null;
  double get _maxMarginLeftPlayerButtonOnPlay =>
      _screenWidth - (_rigthVinyl + _playerButtonSize) - 25;
  double get _maxMarginTopPlayerButtonOnPlay =>
      _screenHeight - (_bottomVinyl + _playerButtonSize) - 25;

  // plus
  double get _leftPlusButton =>
      _isMobile ? _leftPlusButtonMobile : _leftPlusButtonDesktop;
  double get _leftPlusButtonDesktop =>
      _leftPlayerButton - _littleButtonsHorizontalDistance;
  double get _leftPlusButtonMobile =>
      ((_screenWidth - _littleButtonSize) / 2) -
      (_littleButtonSize + _littleButtonsHorizontalDistance);
  double get _topPlusButton =>
      _isMobile ? _topPlusButtonMobile : _topPlusButtonDesktop;
  double get _topPlusButtonDesktop =>
      ((_screenHeight - _playerButtonSize) / 2) -
      _littleButtonSize -
      _littleButtonsVerticalDistance;
  double get _topPlusButtonMobile =>
      _topPlayerButton - _littleButtonsVerticalDistance;

  // save
  double get _leftSaveButton =>
      _isMobile ? _leftSaveButtonMobile : _leftSaveButtonDesktop;
  double get _leftSaveButtonDesktop =>
      _leftPlayerButton - _littleButtonsHorizontalDistance;
  double get _leftSaveButtonMobile =>
      ((_screenWidth - _littleButtonSize) / 2) +
      (_littleButtonSize + _littleButtonsHorizontalDistance);
  double get _topSaveButton =>
      _isMobile ? _topSaveButtonMobile : _topSaveButtonDesktop;
  double get _topSaveButtonDesktop =>
      (_screenHeight + _playerButtonSize) / 2 + _littleButtonsVerticalDistance;
  double get _topSaveButtonMobile =>
      _topPlayerButton - _littleButtonsVerticalDistance;

  bool get _isMobile => _screenWidth / _screenHeight < 3 / 4;
  bool get _isMediumScreen =>
      _screenWidth / _screenHeight >= 3 / 4 &&
      _screenWidth / _screenHeight < 4 / 3;

  @override
  Widget build(BuildContext context) {
    _calculateSizes();

    return MultiBlocProvider(
      providers: [
        BlocProvider<PlatinetteBloc>(
            create: (BuildContext context) => PlatinetteBloc()),
        BlocProvider<PlayerBloc>(
            create: (BuildContext context) => PlayerBloc()),
      ],
      child: BlocListener<PlayerBloc, PlayerState>(
        listener: _onPlayerStateChange,
        child: Stack(
          alignment: _isMobile ? Alignment.topCenter : Alignment.centerLeft,
          children: <Widget>[
            _buildVinyl(),
            _buildPlayerButton(),
            ..._buildOtherButtons(),
          ],
        ),
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
    return AnimatedPositioned(
      top: _topVinyl,
      left: _leftVinyl,
      width: _vinylSize,
      height: _vinylSize,
      duration: _animationDuration,
      curve: _animationCurve,
      child: Image.asset(
        "assets/images/vinyl.png",
        width: _vinylSize,
        height: _vinylSize,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildPlayerButton() {
    return AnimatedPositioned(
      top: _topPlayerButton,
      left: _leftPlayerButton,
      duration: _animationDuration,
      curve: _animationCurve,
      child: UnconstrainedBox(
        child: LimitedBox(
          maxHeight: 200,
          maxWidth: 200,
          child: Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
                borderRadius: BorderRadius.circular(_playerButtonSize)),
            style: AppTheme.neumorphic,
            child: AnimatedPlayerButton(
                duration: _animationDuration,
                diameterCurve: _animationCurve,
                diameter: _playerButtonSize,
                color: AppTheme.whiteFake),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOtherButtons() {
    var _buttons = List<Widget>();
    _buttons.add(AnimatedPositioned(
      duration: _animationDuration,
      curve: _animationCurve,
      top: _topPlusButton,
      left: _leftPlusButton,
      child: Container(
        width: _littleButtonSize,
        height: _littleButtonSize,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(_littleButtonSize)),
          style: AppTheme.neumorphic,
        ),
      ),
    ));

    _buttons.add(AnimatedPositioned(
      duration: _animationDuration,
      curve: _animationCurve,
      top: _topSaveButton,
      left: _leftSaveButton,
      child: Container(
        width: _littleButtonSize,
        height: _littleButtonSize,
        child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(_littleButtonSize)),
          style: AppTheme.neumorphic,
        ),
      ),
    ));

    return _buttons;
  }

  void _calculateSizes() {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    _vinylSize = 0;
    _marginLeftVinyl = 0;
    _marginTopVinyl = 0;

    _marginLeftPlayerButton = 0;
    _marginTopPlayerButton = 0;

    _littleButtonSize = 0;

    if (_isMobile) {
      _calculeMobileSizes();
    } else {
      _calculeDesktopSizes();
    }
  }

  void _calculeDesktopSizes() {
    if (_isMediumScreen) {
      _vinylSize = _isPlaying ? _screenHeight * 1.2 : _screenHeight * 0.7;
    } else {
      _vinylSize = _isPlaying ? _screenHeight * 1.6 : _screenHeight * 0.85;
    }

    _marginLeftVinyl = _isPlaying ? -_vinylSize * 0.25 : _screenWidth * 0.1;
    _playerButtonSize = _screenWidth * 0.2;
    _playerButtonSize = math.min(200, _playerButtonSize);
    _marginLeftPlayerButton =
        _isPlaying ? _screenWidth * 0.095 : _screenWidth * 0.06;
    _marginLeftPlayerButton =
        math.min(_maxMarginLeftPlayerButtonOnPlay, _marginLeftPlayerButton);

    _littleButtonSize = _playerButtonSize * 0.4;
    _littleButtonsVerticalDistance =
        _isPlaying ? _screenHeight * 0.15 : _screenHeight * 0.05;
    _littleButtonsHorizontalDistance =
        _isPlaying ? _littleButtonSize * 0.3 : _littleButtonSize * 0.75;
  }

  void _calculeMobileSizes() {
    _vinylSize = _isPlaying ? _screenHeight * 1.75 : _screenWidth * 0.8;
    _vinylSize = math.min(_vinylSize, _maxVinylSizeOnPlayMobile);
    _playerButtonSize = _screenHeight * 0.15;
    _playerButtonSize = math.min(200, _playerButtonSize);

    _marginTopVinyl = _isPlaying ? -_vinylSize * 0.25 : _screenHeight * 0.05;
    _marginTopPlayerButton =
        _isPlaying ? _screenHeight * 0.095 : _screenHeight * 0.06;
    _marginTopPlayerButton =
        math.min(_maxMarginTopPlayerButtonOnPlay, _marginTopPlayerButton);

    _littleButtonSize = _playerButtonSize * 0.4;
    _littleButtonsVerticalDistance =
        _isPlaying ? _littleButtonSize * 0.3 : _littleButtonSize * 0.75;
    _littleButtonsHorizontalDistance =
        _isPlaying ? _screenWidth * 0.15 : _screenWidth * 0.05;
  }

  void _onPlayerStateChange(BuildContext context, PlayerState state) {
    state.when(
      initial: (rpm) => {},
      playing: (rpm) => setState(() => {_isPlaying = true}),
      paused: (rpm) => setState(() => {_isPlaying = false}),
    );
  }
}
