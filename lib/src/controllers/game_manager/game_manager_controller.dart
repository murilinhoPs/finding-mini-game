import 'package:finding_mini_game/src/controllers/game_manager/game_manager_states.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:flutter/material.dart';

class GameManagerController extends ValueNotifier<GameManagerState> {
  GameManagerController({
    required this.inventoryMaxCapacity,
    required this.inventoryController,
  }) : super(const GameManagerInitial());
  final int inventoryMaxCapacity;
  final InventoryController inventoryController;

  GameManagerState get state => value;

  void gameCompleted() {
    if (inventoryController.collectibles.length == inventoryMaxCapacity) {
      value = const GameManagerLevelComplete();
      return;
    }

    value = const GameManagerLevelIncomplete();
  }

  void gameExited() {
    value = const GameManagerLevelExit();
  }
}
