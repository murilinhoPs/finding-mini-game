import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:finding_mini_game/src/view/mini_game_canvas.dart';
import 'package:finding_mini_game/src/view/widgets/move_image_gesture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';
import 'dart:math' as math;

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
          Align(
            alignment: Alignment.centerRight,
            child: temporaryItemsInventory(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: collectiblesInventory(),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: timerDebug(),
          ),
          Positioned(
            bottom: 12,
            right: 20,
            child: inventoryIcons(),
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
      child: FittedBox(
        fit: BoxFit.contain,
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
    );
  }

  Widget inventoryIcons() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 8.0),
          child: Icon(
            Icons.key,
            size: 30,
            color: Colors.lightBlue[100],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Transform.rotate(
            angle: math.pi / 6,
            child: Container(
              height: 3,
              width: 80,
              color: Colors.lightBlue[50],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.shopping_bag_outlined,
            size: 30,
            color: Colors.lightBlue[100],
          ),
        ),
      ],
    );
  }

  Widget collectiblesInventory() {
    final inventoryController = context.watch<InventoryController>();

    final collectiblesList = List.generate(
      10,
      (index) => Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.blueGrey[800],
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
            ),
            child: inventoryController.collectibles.length > index
                ? RawImage(
                    image: context
                        .read<GameCanvasController>()
                        .images[inventoryController.collectibles[index].image],
                  )
                : const SizedBox(),
          ),
        ),
      ),
    ).toList();

    return Container(
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...collectiblesList,
          const SizedBox(width: 70),
        ],
      ),
    );
  }

  Widget temporaryItemsInventory() {
    final inventoryController = context.watch<InventoryController>();

    final collectiblesList = List.generate(
      4,
      (index) => Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.blueGrey[800],
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
            ),
            child: inventoryController.tempItems.length > index
                ? RawImage(
                    image: context
                        .read<GameCanvasController>()
                        .images[inventoryController.tempItems[index].image],
                  )
                : const SizedBox(),
          ),
        ),
      ),
    ).toList();

    return Container(
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 42, 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...collectiblesList,
          const SizedBox(height: 50),
        ],
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
