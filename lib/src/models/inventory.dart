import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

class Inventory {
  final List<Collectible> collectibles;
  final List<TemporaryItem> tempItems;

  const Inventory({
    this.collectibles = const <Collectible>[],
    this.tempItems = const <TemporaryItem>[],
  });

  Inventory copyWith({
    List<Collectible>? collectibles,
    List<TemporaryItem>? tempItems,
  }) {
    return Inventory(
      collectibles: collectibles ?? this.collectibles,
      tempItems: tempItems ?? this.tempItems,
    );
  }
}
