import 'package:flutter/material.dart';

class MoveImageGesture extends StatelessWidget {
  final Widget child;

  const MoveImageGesture({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      // boundaryMargin: const EdgeInsets.fromLTRB(0, 82, 100, 150),
      scaleEnabled: false,
      child: child,
    );
  }
}
