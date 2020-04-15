import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';

import 'button_hover.dart';

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
    var platinetteBloc = context.bloc<PlatinetteBloc>();
    List<Widget> children = [];
    if (state is PlayerInitial || state is PlayerPaused) {
      children.add(ButtonHover('play', onClick: () => playerBloc.add(Play())));
    } else if (state is PlayerPlaying) {
      children
          .add(ButtonHover('pause', onClick: () => playerBloc.add(Pause())));
    }
    children.add(Container(width: 15));
    children
        .add(ButtonHover('33', onClick: () => playerBloc.add(UpdateRpm(33))));
    children.add(Container(width: 15));
    children
        .add(ButtonHover('45', onClick: () => playerBloc.add(UpdateRpm(45))));
    children.add(Container(width: 15));
    children
        .add(ButtonHover('55', onClick: () => playerBloc.add(UpdateRpm(55))));
    return Row(
      children: children,
    );
  }
}
