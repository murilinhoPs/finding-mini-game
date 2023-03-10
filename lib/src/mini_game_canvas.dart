import 'dart:ui' as ui;

import 'package:finding_mini_game/src/controllers/mini_game_painter_controller.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class MiniGameCanvas extends CustomPainter {
  final BuildContext context;
  final ui.Image background;
  final Map<String, ui.Image> images;
  final MiniGameController controller;

  MiniGameCanvas({
    required this.context,
    required this.images,
    required this.background,
    required this.controller,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var touchyCanvas = TouchyCanvas(context, canvas);

    drawBackground(touchyCanvas, size);
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

    controller.collectibles!.map((colletible) {
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
          print('Tap ${colletible.content!.name}: ${details.localPosition}');
          // showAlertDialog(colletible, context);
        },
      );
    });
  }

  @override
  bool shouldRepaint(MiniGameCanvas oldDelegate) {
    return true;
  }
}
