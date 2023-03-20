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
      boundaryMargin: const EdgeInsets.fromLTRB(2, 82, 2, 82),
      child: child,
    );
  }
}
