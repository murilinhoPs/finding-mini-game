import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:finding_mini_game/src/view/mini_game_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
    required this.backgroundPath,
    required this.jsonPath,
  }) : super(key: key);
  final String jsonPath;
  final String backgroundPath;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GameJsonData>(create: (_) => GameJsonData(jsonPath)),
        ListenableProvider<InventoryController>(
            create: (_) => InventoryController()),
        ListenableProvider<CluesController>(create: (_) => CluesController()),
        ListenableProxyProvider<CluesController, TimerController>(
          update: (_, clues, __) => TimerController(
            cluesController: clues,
            ticker: const Ticker(),
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
            backgroundPath: backgroundPath,
          ),
        ),
      ],
      child: const MiniGameWidget(),
    );
  }
}
