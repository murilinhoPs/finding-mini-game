import 'package:finding_mini_game/src/controllers/game_manager/game_manager_states.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';

class GameManagerController extends ValueNotifier<GameManagerState> {
  GameManagerController({
    required this.inventoryCollectibleLenght,
    required this.items,
  }) : super(const GameManagerInitial());
  final List<Item> items;
  final int inventoryCollectibleLenght;

  int _inventoryMaxCapacity = 0;

  GameManagerState get state => value;

  void initGameManager() {
    for (var item in items) {
      if (item.content != null) {
        _inventoryMaxCapacity++;
      }
    }
  }

  void gameCompleted() {
    //TODO: when adding the mini_game_package, implement this method
    if (inventoryCollectibleLenght == _inventoryMaxCapacity) {
      value = const GameManagerLevelComplete();
      return;
    }

    value = const GameManagerLevelIncomplete();
  }

  void gameExited() {
    //TODO: when adding the mini_game_package, implement this method
    value = const GameManagerLevelExit();
  }
}
