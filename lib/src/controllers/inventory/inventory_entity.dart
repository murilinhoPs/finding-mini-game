import 'package:equatable/equatable.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

class InventoryEntity extends Equatable {
  final List<Collectible> collectibles;
  final List<TemporaryItem> tempItems;

  const InventoryEntity({
    this.collectibles = const <Collectible>[],
    this.tempItems = const <TemporaryItem>[],
  });

  InventoryEntity copyWith({
    List<Collectible>? collectibles,
    List<TemporaryItem>? tempItems,
  }) {
    return InventoryEntity(
      collectibles: collectibles ?? this.collectibles,
      tempItems: tempItems ?? this.tempItems,
    );
  }

  @override
  List<Object?> get props => [collectibles, tempItems];
}
