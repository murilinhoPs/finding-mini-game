import 'package:finding_mini_game/src/model.dart';
import 'package:flutter/material.dart';

class MiniGameController extends ChangeNotifier {
  List<Collectible>? collectibles = [];

  void addCollectible(Collectible collectible) {
    if (collectibles!.contains(collectible)) {
      return;
    }
    collectibles!.add(collectible);
    notifyListeners();
  }
}
