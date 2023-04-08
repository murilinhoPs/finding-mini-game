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

    drawBackground(canvas, size);
    drawCollectibles(touchyCanvas, size);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    if (controller.background == null) return;

    canvas.drawImage(
      controller.background!,
      Offset.zero,
      paint,
    );
  }

  void drawCollectibles(TouchyCanvas canvas, Size size) {
    var paint = Paint()..style = PaintingStyle.fill;

    for (var index = 0; index < controller.items.length; index++) {
      var collectible = controller.items[index];
      if (!collectible.show) return;

      var image = controller.images[collectible.image]!;
      canvas.drawImage(
        image,
        Offset(
          collectible.x - image.width / 2,
          collectible.y - image.height / 2,
        ),
        paint,
        onTapDown: (details) {
          print('Tap ${collectible.image}: ${details.localPosition}');
          // showAlertDialog(Collectible(items.props), context);
          controller.onCanvasItemClick(collectible);
        },
      );
    }
  }

  @override
  bool shouldRepaint(MiniGameCanvas oldDelegate) {
    return false;
  }
}
