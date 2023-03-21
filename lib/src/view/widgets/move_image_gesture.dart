import 'package:flutter/material.dart';

class MoveImageGesture extends StatelessWidget {
  final Widget child;

  const MoveImageGesture({
    super.key,
    required this.child,
  });

  static const offsetTop = 68.0;
  static const offsetBot = 64.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => InteractiveViewer(
        boundaryMargin: EdgeInsets.fromLTRB(
          0,
          constraints.maxHeight / 2 - offsetTop,
          0,
          constraints.maxHeight / 2 - offsetBot,
        ),
        scaleEnabled: false,
        child: child,
      ),
    );
  }
}
