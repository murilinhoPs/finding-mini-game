import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/data/game_json_data.dart';
import 'package:finding_mini_game/src/view/mini_game_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({
    Key? key,
    this.theme,
    required this.backgroundPath,
    required this.jsonPath,
  }) : super(key: key);
  final String jsonPath;
  final String backgroundPath;
  final ThemeData? theme;

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
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return MultiProvider(
            providers: [
              Provider<GameJsonData>(create: (_) => gameJsonData),
              ListenableProvider<InventoryController>(
                create: (_) => InventoryController(),
              ),
              ListenableProvider<CluesController>(
                create: (context) => CluesController(
                  data: context.read<GameJsonData>().cluesData,
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
                  items: context.read<GameJsonData>().items,
                ),
              ),
              ListenableProvider<GameCanvasController>(
                create: (context) => GameCanvasController(
                  items: context.read<GameJsonData>().items,
                  inventoryController: context.read<InventoryController>(),
                  gameManagerController: context.read<GameManagerController>(),
                  backgroundPath: widget.backgroundPath,
                ),
              ),
            ],
            child: MaterialApp(
              theme: widget.theme,
              home: const MiniGameWidget(),
            ),
          );
        });
  }
}
