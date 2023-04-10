import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/view/widgets/clues/clues_widget.dart';
import 'package:finding_mini_game/src/view/widgets/game_canvas/game_canvas_widget.dart';
import 'package:finding_mini_game/src/view/widgets/inventory/collectibles_inventory.dart';
import 'package:finding_mini_game/src/view/widgets/inventory/items_inventory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final inventoryController = context.watch<InventoryController>();
    final canvasController = context.watch<GameCanvasController>();
    final cluesController = context.read<CluesController>();

    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      body: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GameCanvasWidget(
                        canvasController: canvasController,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      child: CollectiblesInventory(
                        inventoryController: inventoryController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 54,
                child: ItemsInventory(
                  inventoryController: inventoryController,
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: CluesWidget(cluesController: cluesController),
          ),
          // SafeArea(
          //   child: Align(
          //     alignment: AlignmentDirectional.bottomStart,
          //     child: TimerDebug(),
          //   ),
          // ),
        ],
      ),
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
