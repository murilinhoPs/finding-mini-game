import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';

class InventoryController extends ValueNotifier<InventoryState> {
  InventoryController() : super(const InventoryState());

  InventoryStatus get status => value.status;
  List<Collectible> get collectibles => value.inventory.collectibles;
  List<TemporaryItem> get tempItems => value.inventory.tempItems;
  List<String> get keyItems => value.keyItems;

  void addTempItem(TemporaryItem item) {
    if (!updateKeyItems(item)) return;
    value = value.copyWith(
      status: InventoryStatus.itemAddSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..add(item),
      ),
    );
  }

  void removeTempItem(TemporaryItem item) {
    if (!updateKeyItems(item, remove: true)) return;
    value = value.copyWith(
      status: InventoryStatus.itemRemoveSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..remove(item),
      ),
    );
  }

  void addCollectible(Collectible collectible) {
    if (collectible.requiredState == null || requiredStateExists(collectible)) {
      print(collectible.content.name);
      value = value.copyWith(
        status: InventoryStatus.collectibleAddSuccess,
        inventory: value.inventory.copyWith(
          collectibles: List.of(collectibles)..add(collectible),
        ),
      );
      return;
    }
    value = value.copyWith(
      status: InventoryStatus.collectibleAddFailure,
    );
  }

  bool updateKeyItems(TemporaryItem item, {bool remove = false}) {
    final itemStates = item.setState.keys.toList();
    for (var i = 0; i < item.setState.length; i++) {
      if (remove) {
        if (!keyItems.contains(itemStates[i])) {
          value = value.copyWith(
            status: InventoryStatus.itemUpdateFailure,
          );
          return false;
        }
        value = value.copyWith(
            keyItems: List.of(keyItems)
              ..removeWhere((state) => state == itemStates[i]));
        return true;
      }

      if (keyItems.contains(itemStates[i])) {
        value = value.copyWith(
          status: InventoryStatus.itemUpdateFailure,
        );
        return false;
      }
      value = value.copyWith(keyItems: List.of(keyItems)..add(itemStates[i]));
      return true;
    }
    return false;
  }

  bool requiredStateExists(Collectible collectible) {
    final requiredStateKeys = collectible.requiredState?.keys.toList() ?? [];
    return requiredStateKeys.every(
      (state) => keyItems.contains(state),
    );
  }
}
