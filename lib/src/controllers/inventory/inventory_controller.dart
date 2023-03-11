import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';

class InventoryController extends ValueNotifier<InventoryState> {
  InventoryController() : super(const InventoryState());

  InventoryStatus get status => value.status;
  List<Collectible> get collectibles => value.inventory.collectibles;
  List<TemporaryItem> get tempItems => value.inventory.tempItems;

  void addTempItem(TemporaryItem item) {
    value = value.copyWith(
      status: InventoryStatus.itemAddSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..add(item),
      ),
    );
    notifyListeners();
  }

  void removeTempItem(TemporaryItem item) {
    value = value.copyWith(
      status: InventoryStatus.itemRemoveSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..remove(item),
      ),
    );
    notifyListeners();
  }

  void addCollectible(Collectible collectible) {
    value = value.copyWith(
      status: InventoryStatus.collectibleAddSuccess,
      inventory: value.inventory.copyWith(
        collectibles: List.of(collectibles)..add(collectible),
      ),
    );
    notifyListeners();
  }
}
