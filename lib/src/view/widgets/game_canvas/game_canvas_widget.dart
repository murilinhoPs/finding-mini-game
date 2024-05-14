import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/view/widgets/game_canvas/mini_game_canvas.dart';
import 'package:finding_mini_game/src/view/widgets/move_image_gesture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class GameCanvasWidget extends StatefulWidget {
  const GameCanvasWidget({
    required this.canvasController,
    super.key,
  });
  final GameCanvasController canvasController;

  @override
  State<GameCanvasWidget> createState() => _GameCanvasWidgetState();
}

class _GameCanvasWidgetState extends State<GameCanvasWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (widget.canvasController.background == null) return const SizedBox();

    return SizedBox(
      width: screenSize.width,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: widget.canvasController.background!.width.toDouble(),
          height: widget.canvasController.background!.height.toDouble(),
          child: MovableWidget(
            screenOffset: Offset(0, MediaQuery.of(context).size.height - 108),
            child: CanvasTouchDetector(
              gesturesToOverride: const [GestureType.onTapDown],
              builder: (context) {
                return CustomPaint(
                  painter: MiniGameCanvas(
                    context: context,
                    controller: context.watch<GameCanvasController>(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
