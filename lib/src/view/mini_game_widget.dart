import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
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
      body: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: backgroundCanvas(),
                    ),
                    collectiblesInventory(),
                  ],
                ),
              ),
              SizedBox(
                width: 60,
                child: itemsInventory(),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 60.0),
                child: cluesWidget(),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: timerDebug(),
            ),
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
        fit: BoxFit.cover,
        child: SizedBox(
          width: canvasController.background!.width.toDouble(),
          height: canvasController.background!.height.toDouble(),
          child: MovableWidget(
            screenOffset: const Offset(0, 200),
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

  Widget inventoryIcons() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Icon(
            Icons.key,
            color: Colors.lightBlue[100],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Transform.rotate(
            angle: math.pi / 6,
            child: Container(
              height: 3,
              width: 60,
              color: Colors.lightBlue[50],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40, top: 4.0, bottom: 8.0),
          child: Icon(
            Icons.shopping_bag_outlined,
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
      (index) => SizedBox(
        height: 40,
        width: 40,
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
                : null,
          ),
        ),
      ),
    ).toList();

    return Container(
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: collectiblesList,
      ),
    );
  }

  Widget itemsInventory() {
    final inventoryController = context.watch<InventoryController>();

    final collectiblesList = List.generate(
      5,
      (index) => SizedBox(
        height: 40,
        width: 40,
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
                : null,
          ),
        ),
      ),
    ).toList();

    return Container(
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...collectiblesList,
                ],
              ),
            ),
          ),
          inventoryIcons()
        ],
      ),
    );
  }

  Widget cluesWidget() {
    final cluesController = context.watch<CluesController>();

    return Container(
      color: Colors.black45,
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: cluesController.status == CluesStatus.cluesHide
            ? MainAxisSize.min
            : MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              if (cluesController.status == CluesStatus.cluesHide) {
                cluesController.onCluesShow();
                return;
              }
              cluesController.closeClues();
            },
            icon: const Icon(
              Icons.help_center,
              color: Colors.white,
            ),
          ),
          if (cluesController.status == CluesStatus.cluesOpen)
            Text(
              'Clues',
              style: TextStyle(
                color: Colors.white,
              ),
            )
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
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state is TimerInitial) ...[
          ElevatedButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => timerController.startTimer(),
          ),
        ],
        Text(
          'timer: $minutesStr:$secondsStr',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            backgroundColor:
                state is TimerRunComplete ? Colors.lightGreen : Colors.red,
            child: const Icon(
              Icons.restore,
              size: 14,
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
