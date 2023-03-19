import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/view/mini_game_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    Key? key,
    required this.backgroundPath,
    required this.jsonPath,
  }) : super(key: key);
  final String jsonPath;
  final String backgroundPath;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late GameJsonData gameJsonData;

  @override
  void initState() {
    gameJsonData = GameJsonData(widget.jsonPath);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gameJsonData.loadJson(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return MultiProvider(
            providers: [
              Provider<GameJsonData>(create: (_) => gameJsonData),
              ListenableProvider<InventoryController>(
                create: (_) => InventoryController(),
              ),
              ListenableProxyProvider<GameJsonData, CluesController>(
                create: (context) => CluesController(
                  data: context.read<GameJsonData>().cluesData,
                ),
                update: (_, data, __) => CluesController(data: data.cluesData),
              ),
              ListenableProxyProvider<CluesController, TimerController>(
                create: (context) => TimerController(
                  cluesController: context.read<CluesController>(),
                ),
                update: (_, clues, __) => TimerController(
                  cluesController: clues,
                ),
              ),
              ListenableProxyProvider2<GameJsonData, InventoryController,
                  GameManagerController>(
                update: (_, gameData, inventory, __) => GameManagerController(
                  inventoryCollectibleLenght: inventory.collectibles.length,
                  items: gameData.items,
                ),
              ),
              ListenableProxyProvider3<GameJsonData, InventoryController,
                  GameManagerController, GameCanvasController>(
                update: (_, gameData, inventory, gameManager, __) =>
                    GameCanvasController(
                  items: gameData.items,
                  inventoryController: inventory,
                  gameManagerController: gameManager,
                  backgroundPath: widget.backgroundPath,
                ),
              ),
            ],
            child: const MiniGameWidget(),
          );
        });
  }
}
