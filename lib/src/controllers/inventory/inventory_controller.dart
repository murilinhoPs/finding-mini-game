//TODO: vai ter o estado pra exportar pro journal
// inventario temporario, com itens tipo chave....
// que não vão para o journal
// states: Add tempItem add Collectible

import 'package:finding_mini_game/src/models/inventory.dart';
import 'package:finding_mini_game/src/models/mini_game.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';

class InventoryController extends ValueNotifier<InventoryModel> {
  InventoryController()
      : super(const InventoryModel(
          collectibles: [],
          tempItems: [],
        ));

  List<Collectible>? get collectibles => value.collectibles;
  List<TemporaryItem>? get tempItems => value.tempItems;

  void addTempItems(TemporaryItem item) {
    value.tempItems.add(item);
    notifyListeners();
  }

  void addCollectible(Collectible collectible) {
    value.collectibles.add(collectible);
    notifyListeners();
  }
}
