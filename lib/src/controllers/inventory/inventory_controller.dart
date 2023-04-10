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

  void removeTempItem(Collectible collectible) {
    if (value.inventory.tempItems.isEmpty) {
      value = value.copyWith(
        status: InventoryStatus.itemUpdateFailure,
      );
      return;
    }
    final collectibleKeys = collectible.requiredState!.keys.toList();
    final item = value.inventory.tempItems.firstWhere(
      (item) => collectibleKeys.every(
        (state) => item.setState.keys.contains(state),
      ),
    );
    if (!updateKeyItems(item, remove: true)) return;
    value = value.copyWith(
      status: InventoryStatus.itemRemoveCollectibeAddSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..remove(item),
      ),
    );
  }

  void addCollectible(Collectible collectible) {
    if (collectible.requiredState == null ||
        requiredStateExists(collectible.requiredState)) {
      value = value.copyWith(
        status: InventoryStatus.collectibleAddSuccess,
        inventory: value.inventory.copyWith(
          collectibles: List.of(collectibles)..add(collectible),
        ),
      );
      if (requiredStateExists(collectible.requiredState) &&
          collectible.requiredState != null) {
        removeTempItem(collectible);
      }
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

  bool requiredStateExists(Map<String, bool>? collectibleState) {
    final requiredStateKeys = collectibleState?.keys.toList() ?? [];
    return requiredStateKeys.every(
      (state) => keyItems.contains(state),
    );
  }
}
