import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/inventory.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

enum InventoryStatus {
  initial,
  collectibleAddSuccess,
  itemAddSuccess,
  itemRemoveSuccess
}

class InventoryState {
  final InventoryStatus status;
  final Inventory inventory;

  const InventoryState({
    this.status = InventoryStatus.initial,
    this.inventory = const Inventory(
      tempItems: <TemporaryItem>[],
      collectibles: <Collectible>[],
    ),
  });

  InventoryState copyWith({
    InventoryStatus? status,
    Inventory? inventory,
  }) {
    return InventoryState(
      inventory: inventory ?? this.inventory,
      status: status ?? this.status,
    );
  }
}
