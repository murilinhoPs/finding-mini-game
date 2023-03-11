import 'package:finding_mini_game/src/models/mini_game.dart';
import 'package:flutter/material.dart';

class MiniGameController extends ValueNotifier<List<Collectible>?> {
  MiniGameController() : super([]);

  List<Collectible>? get collectibles => value;

  void addCollectible(Collectible collectible) {
    if (value!.contains(collectible)) {
      return;
    }
    value!.add(collectible);
    notifyListeners();
  } //ValueListenableBuilder
}
