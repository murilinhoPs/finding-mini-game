import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class MiniGameCanvas extends CustomPainter {
  final BuildContext context;
  final GameCanvasController controller;

  MiniGameCanvas({
    required this.context,
    required this.controller,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);

    drawBackground(touchyCanvas, size);
    drawCollectibles(touchyCanvas, size);
  }

  void drawBackground(TouchyCanvas canvas, Size size) {
    final paint = Paint();

    canvas.drawImage(
      controller.background!,
      Offset.zero,
      paint,
      onTapDown: (details) => print('BabkgoundTap: ${details.localPosition}'),
    );
  }

  void drawCollectibles(TouchyCanvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    controller.items.map((colletible) {
      if (!colletible.show) return;

      var image = controller.images[colletible.image]!;
      canvas.drawImage(
        image,
        Offset(
          colletible.x - image.width / 2,
          colletible.y - image.height / 2,
        ),
        paint,
        onTapDown: (details) {
          print('Tap ${colletible.image}: ${details.localPosition}');
          // showAlertDialog(Collectible(items.props), context);
          controller.onCanvasItemClick(colletible);
        },
      );
    });
  }

  @override
  bool shouldRepaint(MiniGameCanvas oldDelegate) {
    return false;
  }
}
