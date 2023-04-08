import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/view/widgets/game_canvas/mini_game_canvas.dart';
import 'package:finding_mini_game/src/view/widgets/move_image_gesture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class GameCanvasWidget extends StatefulWidget {
  const GameCanvasWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GameCanvasWidget> createState() => _GameCanvasWidgetState();
}

class _GameCanvasWidgetState extends State<GameCanvasWidget> {
  late GameCanvasController canvasController;

  @override
  void initState() {
    canvasController = context.watch<GameCanvasController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (canvasController.background == null) return const SizedBox();

    return SizedBox(
      width: screenSize.width,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: canvasController.background!.width.toDouble(),
          height: canvasController.background!.height.toDouble(),
          child: MovableWidget(
            screenOffset: const Offset(0, 198),
            child: CanvasTouchDetector(
              gesturesToOverride: const [GestureType.onTapDown],
              builder: (context) {
                return CustomPaint(
                  painter: MiniGameCanvas(
                    context: context,
                    controller: canvasController,
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
