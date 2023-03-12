import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';

class InventoryController extends ValueNotifier<InventoryState> {
  InventoryController() : super(const InventoryState());

  InventoryStatus get status => value.status;
  List<Collectible> get collectibles => value.inventory.collectibles;
  List<TemporaryItem> get tempItems => value.inventory.tempItems;
  List<String> get keyItemsState => value.keyItemsState;

  void addTempItem(TemporaryItem item) {
    setKeyItemsState(item);

    value = value.copyWith(
      status: InventoryStatus.itemAddSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..add(item),
      ),
    );
    notifyListeners();
  }

  void removeTempItem(TemporaryItem item) {
    setKeyItemsState(item, remove: true);

    value = value.copyWith(
      status: InventoryStatus.itemRemoveSuccess,
      inventory: value.inventory.copyWith(
        tempItems: List.of(tempItems)..remove(item),
      ),
    );
    notifyListeners();
  }

  void addCollectible(Collectible collectible) {
    if (collectible.requiredState == null || requiredStateExists(collectible)) {
      value = value.copyWith(
        status: InventoryStatus.collectibleAddSuccess,
        inventory: value.inventory.copyWith(
          collectibles: List.of(collectibles)..add(collectible),
        ),
      );
      notifyListeners();
    }
  }

  void setKeyItemsState(TemporaryItem item, {bool remove = false}) {
    final itemStates = item.setState.keys.toList();

    for (var i = 0; i < item.setState.length; i++) {
      if (remove) {
        if (!keyItemsState.contains(itemStates[i])) return;
        value = value.copyWith(
            keyItemsState: List.of(keyItemsState)
              ..removeWhere((state) => state == itemStates[i]));
        return;
      }
      if (keyItemsState.contains(itemStates[i])) return;
      value = value.copyWith(
          keyItemsState: List.of(keyItemsState)..add(itemStates[i]));
    }
  }

  bool requiredStateExists(Collectible collectible) {
    final requiredStateKeys = collectible.requiredState?.keys.toList() ?? [];
    return requiredStateKeys.every(
      (state) {
        print('contains? ${keyItemsState.contains(state)}');
        return keyItemsState.contains(state);
      },
    );
  }
}
