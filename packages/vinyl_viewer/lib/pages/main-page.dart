import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vinyl_viewer/blocs/platinette/platinette_bloc.dart';
import 'package:vinyl_viewer/blocs/player/player_bloc.dart';
import 'package:vinyl_viewer/widgets/button_bar.dart';
import 'package:vinyl_viewer/widgets/button_hover.dart';
import 'package:vinyl_viewer/widgets/platinette_button/player_button.dart';
import 'package:vinyl_viewer/widgets/recordable_rotating_macaron.dart';
import 'package:vinyl_viewer/widgets/recording_overlay.dart';

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
      // child: Container(),
      child: PlayerButton(diameter: 300),
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
          // style: NeumorphicStyle(shape: NeumorphicShape.flat),
          // boxShape: NeumorphicBoxShape.circle(),
          // padding: const EdgeInsets.all(12.0),
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
}
