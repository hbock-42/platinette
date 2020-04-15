import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/widgets/button_bar.dart';
import 'package:vinyl_viewer/widgets/button_hover.dart';
import 'package:vinyl_viewer/widgets/recordable_rotating_macaron.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlatinetteBloc>(
            create: (BuildContext context) => PlatinetteBloc()),
        BlocProvider<PlayerBloc>(
            create: (BuildContext context) => PlayerBloc()),
      ],
      child: BlocBuilder<PlatinetteBloc, PlatinetteState>(
        builder: (BuildContext context, PlatinetteState state) {
          return Stack(
            children: [
              Container(
                color: Colors.blue,
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      buildButtonBar(context, state),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: RecordableRotatingMacaron(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is PlatinettePickingFile)
                Container(color: Colors.grey.withOpacity(0.4)),
              if (state is PlatinetteRecording) Container(),
            ],
          );
        },
      ),
    );
  }

  Widget buildButtonBar(BuildContext context, PlatinetteState state) {
    var platinetteBloc = context.bloc<PlatinetteBloc>();
    return Row(
      children: [
        ButtonHover(
          'get file',
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
}