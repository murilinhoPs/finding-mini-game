import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';

class MiniGameController extends ValueNotifier<List<Items>?> {
  MiniGameController() : super([]);

  List<Items>? get collectibles => value;

  void addCollectible(Items collectible) {
    if (value!.contains(collectible)) {
      return;
    }
    value!.add(collectible);
    notifyListeners();
  } //ValueListenableBuilder
}
