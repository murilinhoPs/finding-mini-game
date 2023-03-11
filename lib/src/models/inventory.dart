import 'package:finding_mini_game/src/models/mini_game.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

class InventoryModel {
  final List<Collectible>? collectibles;
  final List<TemporaryItem>? tempItem;

  const InventoryModel({
    this.tempItem,
    this.collectibles,
  });
}
