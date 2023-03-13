import 'dart:ui' as ui;

import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class MiniGameCanvas extends CustomPainter {
  final BuildContext context;
  final ui.Image background;
  final Map<String, ui.Image> images;
  final List<Item>? items;
  final GameCanvasController gameCanvasController;

  MiniGameCanvas({
    required this.context,
    required this.images,
    required this.background,
    required this.items,
    required this.gameCanvasController,
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
      background,
      Offset.zero,
      paint,
      onTapDown: (details) => print('BabkgoundTap: ${details.localPosition}'),
    );
  }

  void drawCollectibles(TouchyCanvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    items!.map((colletible) {
      if (!colletible.show) return;

      var image = images[colletible.image]!;
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
          gameCanvasController.onCanvasItemClick(colletible);
        },
      );
    });
  }

  @override
  bool shouldRepaint(MiniGameCanvas oldDelegate) {
    return false;
  }
}
