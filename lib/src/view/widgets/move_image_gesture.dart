import 'package:flutter/material.dart';

typedef OffsetBuilder = Offset Function(Size size);

class Exp3 extends StatefulWidget {
  final Widget child;

  const Exp3({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Exp3> createState() => _Exp3State();
}

class _Exp3State extends State<Exp3> {
  // function that takes size of the child container and returns its new offset based on the size.
  // initial offset of the child container is (0, 0).
  OffsetBuilder _offsetBuilder = (_) => Offset.zero;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      // parent container
      height: 300,
      width: 3000, // screenSize.width,
      color: Colors.red,
      child: GestureDetector(
        onPanUpdate: (details) {
          // get the current offset builder before we modify it
          // because we want to use it in the new offset builder
          final currentBuilder = _offsetBuilder;

          // create the new offset builder
          _offsetBuilder = (Size containerSize) {
            // the container size will be passed to you in this function
            // you can use it to place your widget
            // return the offset you like for the top left of the container
            // now we will return the current offset + the delta
            // Just be careful if you set canGoOffParentBounds to false, as this will prevent the widget from being painted outside the parent
            // but it WILL NOT prevent the offset from being updated to be outside parent, you should handle this in this case, see below:
            return currentBuilder.call(containerSize * 2) + details.delta;
          };
          setState(
            () {},
          ); // to update the UI (force rerender of the CustomSingleChildLayout)
        },
        child: CustomSingleChildLayout(
          delegate: MyCustomSingleChildLayoutDelegate(
            canGoOffParentBounds: false,
            padding: EdgeInsets.zero,
            offsetBuilder: _offsetBuilder,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class MyCustomSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  final Offset Function(Size childSize) offsetBuilder;
  final EdgeInsets padding;
  final bool canGoOffParentBounds;

  MyCustomSingleChildLayoutDelegate({
    required this.offsetBuilder,
    required this.padding,
    required this.canGoOffParentBounds,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The content can be at most the size of the parent minus 8.0 pixels in each
    // direction.
    return constraints.deflate(padding);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // childSize: size of the content
    Offset childTopLeft = offsetBuilder.call(childSize);
    // print(childSize.height);
    print('dy: ${childTopLeft.dy}');

    if (canGoOffParentBounds) {
      // no more checks on the position needed
      return childTopLeft;
    }

    // make sure the child does not go off screen in all directions
    // and respects the padding
    if (childTopLeft.dx + childSize.width > size.width - padding.right) {
      final distance =
          -(childTopLeft.dx - (size.width - padding.right - childSize.width));
      childTopLeft = childTopLeft.translate(distance, 0);
    }
    if (childTopLeft.dx < padding.left) {
      final distance = padding.left - childTopLeft.dx;
      childTopLeft = childTopLeft.translate(distance, 0);
    }

    if (childTopLeft.dy + childSize.height > size.height - padding.bottom) {
      final distance = -(childTopLeft.dy -
          (size.height - padding.bottom - childSize.height));
      childTopLeft = childTopLeft.translate(0, distance);
    }
    if (childTopLeft.dy < padding.top) {
      final distance = padding.top - childTopLeft.dy;
      //distance = - childTopLeft.dy
      print(distance);
      // childTopLeft = childTopLeft.translate(0, distance); ele para nessa distancia 204;
    }
    return childTopLeft;
  }

  @override
  bool shouldRelayout(MyCustomSingleChildLayoutDelegate oldDelegate) {
    return oldDelegate.offsetBuilder != offsetBuilder;
  }
}

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
    return Expanded(
      child: LayoutBuilder(
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
      ),
    );
  }
}

class MovableWidget extends StatefulWidget {
  final Widget child;

  const MovableWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<MovableWidget> createState() => _MovableWidgetState();
}

class _MovableWidgetState extends State<MovableWidget> {
  final sizeLimit = const Size(500, 300);

  Offset localOffset = Offset.zero;

  updatePosition(BoxConstraints constraints, DragUpdateDetails t) {
    var dx = 0.0;
    var dy = 0.0;
    debugPrint(t.localPosition.toString());
    // print(constraints.maxWidth);
    // print(t.localPosition.dx < constraints.maxWidth - sizeLimit.width);

    // // * using single condition force to one dimension
    // if (t.globalPosition.dx < constraints.maxWidth - sizeLimit.width / 2 &&
    //     t.globalPosition.dx > sizeLimit.width / 2 &&
    //     t.localPosition.dy > sizeLimit.height / 2 &&
    //     t.localPosition.dy < constraints.maxHeight - sizeLimit.height / 2) {
    //   localOffset += t.delta;
    // }

    if (t.localPosition.dx < constraints.maxWidth / 2
        // && t.localPosition.dx > sizeLimit.width
        ) {
      dx = t.delta.dx;
    }
    // if (t.localPosition.dy > sizeLimit.height / 2 &&
    //     t.localPosition.dy < constraints.maxHeight - sizeLimit.height / 2) {
    //   dy = t.delta.dy;
    // }
    localOffset += Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: ((details) {
          setState(() {
            updatePosition(constraints, details);
          });
        }),
        child: Transform.translate(
          offset: localOffset,
          child: widget.child,
        ),
      );
    });
  }
}
