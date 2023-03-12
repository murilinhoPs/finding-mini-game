import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/inventory.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

enum InventoryStatus {
  initial,
  collectibleAddSuccess,
  itemAddSuccess,
  itemRemoveSuccess
}

class InventoryState {
  final InventoryStatus status;
  final List<String> keyItemsState;
  final Inventory inventory;

  const InventoryState({
    this.status = InventoryStatus.initial,
    this.keyItemsState = const <String>[],
    this.inventory = const Inventory(
      tempItems: <TemporaryItem>[],
      collectibles: <Collectible>[],
    ),
  });

  InventoryState copyWith({
    InventoryStatus? status,
    Inventory? inventory,
    List<String>? keyItemsState,
  }) {
    return InventoryState(
      inventory: inventory ?? this.inventory,
      status: status ?? this.status,
      keyItemsState: keyItemsState ?? this.keyItemsState,
    );
  }
}
