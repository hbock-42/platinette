import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class LottieButton extends StatefulWidget {
  final void Function() onClick1;
  final void Function() onClick2;
  final bool isFirstStatefirst;
  final String compositionPath;
  final double height;
  final double width;

  const LottieButton({
    Key key,
    this.onClick1,
    this.onClick2,
    this.isFirstStatefirst = true,
    this.compositionPath,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _LottieButtonState createState() => _LottieButtonState();
}

class _LottieButtonState extends State<LottieButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Future<LottieComposition> _composition;
  bool _isFirstState;

  @override
  void initState() {
    super.initState();
    _isFirstState = widget.isFirstStatefirst;
    _controller = AnimationController(vsync: this);
    _controller.value = _isFirstState ? 0 : 1;
    _composition = _loadComposition();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load(widget.compositionPath);
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Listener(
            onPointerUp: (event) =>
                _manageClickController(Duration(milliseconds: 200)),
            child: Container(
              // color: Colors.blue,
              child: Lottie(
                controller: _controller,
                composition: composition,
                height: widget.height,
                width: widget.width,
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _manageClickController(Duration duration) {
    _controller.duration = duration;
    setState(() {
      if (_isFirstState) {
        _controller.forward();
        if (widget.onClick1 != null) {
          widget.onClick1();
        }
      } else {
        _controller.reverse();
        if (widget.onClick2 != null) {
          widget?.onClick2();
        }
      }
      _isFirstState = !_isFirstState;
    });
  }
}
