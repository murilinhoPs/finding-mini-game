import 'package:flutter/material.dart';

typedef OffsetBuilder = Offset Function(Size size);

class MovableWidget extends StatefulWidget {
  final Widget child;
  final Offset screenOffset;

  const MovableWidget({
    Key? key,
    required this.child,
    required this.screenOffset,
  }) : super(key: key);

  @override
  State<MovableWidget> createState() => _MovableWidgetState();
}

class _MovableWidgetState extends State<MovableWidget> {
  OffsetBuilder _offsetBuilder = (size) => Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final currentBuilder = _offsetBuilder;

        _offsetBuilder = (Size containerSize) =>
            currentBuilder.call(containerSize) + details.delta;
        setState(() {});
      },
      child: CustomSingleChildLayout(
        delegate: MovableImageSingleChildLayoutDelegate(
          canGoOffParentBounds: false,
          padding: EdgeInsets.zero,
          offsetBuilder: _offsetBuilder,
          screenOffset: widget.screenOffset,
        ),
        child: widget.child,
      ),
    );
  }
}

class MovableImageSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  final Offset Function(Size childSize) offsetBuilder;
  final Offset screenOffset;
  final EdgeInsets padding;
  final bool canGoOffParentBounds;

  MovableImageSingleChildLayoutDelegate({
    required this.offsetBuilder,
    required this.screenOffset,
    required this.padding,
    required this.canGoOffParentBounds,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.deflate(padding);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // childSize: size of the content
    Offset childTopLeft = offsetBuilder.call(childSize);

    if (canGoOffParentBounds) {
      return childTopLeft;
    }

    // make sure the child does not go off screen in all directions
    // and respects the padding
    if (childTopLeft.dx + childSize.width > (size.width - padding.right)) {
      final distance =
          -(childTopLeft.dx - (size.width - padding.right - childSize.width));
      childTopLeft = childTopLeft.translate(distance, 0);
    }
    if (childTopLeft.dx < padding.left) {
      final distance = padding.left - childTopLeft.dx;
      childTopLeft = childTopLeft.translate(distance, 0);
    }
    if (childTopLeft.dy + childSize.height >
        (size.height - padding.bottom) + screenOffset.dy) {
      final distance = -(childTopLeft.dy -
          (size.height - padding.bottom - childSize.height) -
          screenOffset.dy);
      childTopLeft = childTopLeft.translate(0, distance);
    }
    if (childTopLeft.dy < padding.top - screenOffset.dy) {
      final distance = (padding.top - childTopLeft.dy) - screenOffset.dy;
      childTopLeft = childTopLeft.translate(0, distance);
    }
    return childTopLeft;
  }

  @override
  bool shouldRelayout(MovableImageSingleChildLayoutDelegate oldDelegate) {
    return oldDelegate.offsetBuilder != offsetBuilder;
  }
}
