import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';

import 'button_hover.dart';
import 'lottie_button.dart';

class PlayerButtonBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (BuildContext context, PlayerState state) {
        return buildPlayerButtonBar(context, state);
      },
    );
  }

  Widget buildPlayerButtonBar(BuildContext context, PlayerState state) {
    var playerBloc = context.bloc<PlayerBloc>();
    List<Widget> children = [];
    children.add(LottieButton(
      onClick1: () => playerBloc.add(Pause()),
      onClick2: () => playerBloc.add(Play()),
      isFirstStatefirst: false,
      compositionPath: 'assets/animations/play_pause.json',
      height: 65,
    ));
    children.add(Container(width: 15));
    children
        .add(ButtonHover('33', onClick: () => playerBloc.add(UpdateRpm(33))));
    children.add(Container(width: 15));
    children
        .add(ButtonHover('45', onClick: () => playerBloc.add(UpdateRpm(45))));
    children.add(Container(width: 15));
    children
        .add(ButtonHover('55', onClick: () => playerBloc.add(UpdateRpm(55))));
    return IntrinsicHeight(
      child: Wrap(
        spacing: 0,
        // runSpacing: 10,
        children: children,
      ),
    );
  }
}
