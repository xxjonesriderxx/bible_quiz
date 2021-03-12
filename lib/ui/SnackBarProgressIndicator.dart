import 'package:flutter/material.dart';

class SnackBarProgressIndicator extends StatefulWidget {
  final Duration duration;
  final VoidCallback onComplete;

  const SnackBarProgressIndicator({Key key, @required this.duration, @required this.onComplete}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(duration: duration, onComplete: onComplete);
  }
}

class _State extends State<SnackBarProgressIndicator> with TickerProviderStateMixin {
  final Duration duration;
  final VoidCallback onComplete;
  AnimationController controller;

  _State({this.duration, this.onComplete});

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    controller.forward().whenComplete(() => onComplete());
    controller.addListener(() {
      if (mounted && !controller.isDismissed) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      semanticsLabel: 'Linear progress indicator',
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
