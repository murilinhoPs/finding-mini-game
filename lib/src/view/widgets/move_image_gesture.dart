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

    bool moveUpBounds = childTopLeft.dy < padding.top - screenOffset.dy;
    bool moveDownBounds = childTopLeft.dy + childSize.height >
        (size.height - padding.bottom) + screenOffset.dy;
    bool moveLeftBounds = childTopLeft.dx < padding.left - screenOffset.dx;
    bool moveRightBounds = childTopLeft.dx + childSize.width >
        (size.width - padding.right) + screenOffset.dx;
    // make sure the child does not go off screen in all directions
    // and respects the padding
    if (moveRightBounds) {
      final distance = -(childTopLeft.dx -
          (size.width - padding.right - childSize.width) -
          screenOffset.dx);
      childTopLeft = childTopLeft.translate(distance, 0);
    }
    if (moveLeftBounds) {
      final distance = (padding.left - childTopLeft.dx) - screenOffset.dx;
      childTopLeft = childTopLeft.translate(distance, 0);
    }
    if (moveDownBounds) {
      final distance = -(childTopLeft.dy -
          (size.height - padding.bottom - childSize.height) -
          screenOffset.dy);
      childTopLeft = childTopLeft.translate(0, distance);
    }
    if (moveUpBounds) {
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
