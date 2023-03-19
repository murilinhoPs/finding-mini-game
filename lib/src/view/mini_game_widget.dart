import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniGameWidget extends StatefulWidget {
  final String backgroundPath;
  final String miniGameJsonpath;
  const MiniGameWidget({
    Key? key,
    required this.backgroundPath,
    required this.miniGameJsonpath,
  }) : super(key: key);

  @override
  State<MiniGameWidget> createState() => _MiniGameWidgetState();
}

class _MiniGameWidgetState extends State<MiniGameWidget> {
  late GameJsonData gameData;
  late GameManagerController gameManager;
  late InventoryController inventoryController;
  late GameCanvasController canvasController;
  late CluesController cluesController;
  late TimerController timerController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    gameData = GameJsonData(widget.miniGameJsonpath);

    inventoryController = InventoryController();
    cluesController = CluesController();
    gameManager = GameManagerController(
      inventoryCollectibleLenght: inventoryController.collectibles.length,
      items: gameData.items,
    );
    canvasController = GameCanvasController(
      inventoryController: inventoryController,
      items: gameData.items,
      backgroundPath: widget.backgroundPath,
      gameManagerController: gameManager,
    );
    timerController = TimerController(
        ticker: const Ticker(), cluesController: cluesController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Mini-game'),
        backgroundColor: Colors.white12,
      ),
      body: Center(
          child: Column(
        children: [
          timerDebug(),
        ],
      )),
    );
  }

  Widget timerDebug() {
    return ValueListenableBuilder(
      valueListenable: timerController,
      builder: (_, TimerState state, child) {
        final duration = timerController.value.duration;
        final minutesStr =
            ((duration / 60) % 60).floor().toString().padLeft(2, '0');
        final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is TimerInitial) ...[
              ElevatedButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => timerController.startTimer(0),
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
      },
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
