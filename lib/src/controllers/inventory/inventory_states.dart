import 'package:equatable/equatable.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/inventory.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

enum InventoryStatus {
  initial,
  collectibleAddSuccess,
  collectibleAddFailure,
  itemAddSuccess,
  itemRemoveSuccess,
  itemUpdateFailure,
}

class InventoryState extends Equatable {
  final InventoryStatus status;
  final List<String> keyItems;
  final Inventory inventory;

  const InventoryState({
    this.status = InventoryStatus.initial,
    this.keyItems = const <String>[],
    this.inventory = const Inventory(
      tempItems: <TemporaryItem>[],
      collectibles: <Collectible>[],
    ),
  });

  InventoryState copyWith({
    InventoryStatus? status,
    Inventory? inventory,
    List<String>? keyItems,
  }) {
    return InventoryState(
      inventory: inventory ?? this.inventory,
      status: status ?? this.status,
      keyItems: keyItems ?? this.keyItems,
    );
  }

  @override
  List<Object?> get props => [inventory, status, keyItems];
}
