import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/data/game_data_repository.dart';
import 'package:finding_mini_game/src/data/game_json_data_repository_impl.dart';
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
  late GameDataRepository gameJsonData;
  late Future<MiniGameDataModel> gameData;

  @override
  void initState() {
    gameJsonData = GameJsonDataRepositoryImpl(widget.jsonPath);
    gameData = gameJsonData.loadJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: gameData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return MultiProvider(
            providers: [
              Provider<GameDataRepository>(
                create: (_) => gameJsonData,
              ),
              ListenableProvider<InventoryController>(
                create: (_) => InventoryController(),
              ),
              ListenableProvider<CluesController>(
                create: (context) => CluesController(
                  data: context.read<GameDataRepository>().cluesData,
                ),
              ),
              ListenableProvider<TimerController>(
                create: (context) => TimerController(
                  cluesController: context.read<CluesController>(),
                ),
              ),
              ListenableProvider<GameManagerController>(
                create: (context) => GameManagerController(
                  inventoryCollectibleLenght:
                      context.read<InventoryController>().collectibles.length,
                  items: context.read<GameDataRepository>().items,
                ),
              ),
              ListenableProvider<GameCanvasController>(
                create: (context) => GameCanvasController(
                  items: context.read<GameDataRepository>().items,
                  inventoryController: context.read<InventoryController>(),
                  gameManagerController: context.read<GameManagerController>(),
                  backgroundPath: widget.backgroundPath,
                ),
              ),
            ],
            child: const MiniGameWidget(),
          );
        });
  }
}
