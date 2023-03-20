import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:finding_mini_game/src/view/mini_game_canvas.dart';
import 'package:finding_mini_game/src/view/widgets/move_image_gesture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class MiniGameWidget extends StatefulWidget {
  const MiniGameWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MiniGameWidget> createState() => _MiniGameWidgetState();
}

class _MiniGameWidgetState extends State<MiniGameWidget> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CluesController>().createClues();
      context.read<TimerController>().startTimer();
      context.read<GameManagerController>().initGameManager();
      context.read<GameCanvasController>().initCanvas();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Mini-game'),
      //   backgroundColor: Colors.white12,
      // ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          backgroundCanvas(),
          Positioned(
            top: 4,
            left: 4,
            child: timerDebug(),
          ),
        ],
      ),
    );
  }

  Widget backgroundCanvas() {
    final screenSize = MediaQuery.of(context).size;
    final canvasController = context.watch<GameCanvasController>();

    if (canvasController.background == null) return const SizedBox();

    return SizedBox(
      width: screenSize.width,
      child: MoveImageGesture(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: canvasController.background!.width.toDouble(),
            height: canvasController.background!.height.toDouble(),
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

  Widget timerDebug() {
    final timerController = context.watch<TimerController>();
    final state = timerController.value;
    final minutesStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state is TimerInitial) ...[
          ElevatedButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => timerController.startTimer(),
          ),
        ],
        Text(
          'debugTimer: $minutesStr:$secondsStr',
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 30,
          child: FloatingActionButton(
            backgroundColor:
                state is TimerRunComplete ? Colors.lightGreen : Colors.red,
            child: const Icon(
              Icons.restore,
              size: 20,
            ),
            onPressed: () => timerController.timerReset(),
          ),
        ),
      ],
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
