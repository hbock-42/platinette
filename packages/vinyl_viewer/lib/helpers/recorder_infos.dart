library recorder_info;

class Fps {
  final int _value;

  const Fps._(this._value);
  int toInt() {
    return _value;
  }

  static const Fps Fps5 = Fps._(5);
  static const Fps Fps10 = Fps._(10);
  static const Fps Fps20 = Fps._(20);
  static const Fps Fps25 = Fps._(25);
  static const Fps Fps50 = Fps._(50);
}

class RecorderInfo {
  final Fps fps;
  int frameRequested;
  List<int> frameDurationsInMs;

  RecorderInfo(this.fps, int durationInMs) {
    double dottedFrameCount =
        (fps.toInt() * durationInMs).roundToDouble() / 1000;
    int frameDurationInMs = (1000 / fps.toInt()).round();
    if (dottedFrameCount.round().roundToDouble() == dottedFrameCount) {
      frameRequested = dottedFrameCount.round();
      frameDurationsInMs = List<int>.filled(frameRequested, frameDurationInMs);
    } else {
      frameRequested = dottedFrameCount.floor() + 1;
      frameDurationsInMs = List<int>.filled(frameRequested, frameDurationInMs);
      frameDurationsInMs.last =
          durationInMs - (dottedFrameCount.floor() * frameDurationInMs);
    }
  }
}
