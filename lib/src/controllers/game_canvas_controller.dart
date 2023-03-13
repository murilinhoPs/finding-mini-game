import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';

enum GameCanvasStatus { itemCreatedSuccess, collectibleCreatedSuccess, error }

class GameCanvasController {
  const GameCanvasController(this.inventoryController);
  final InventoryController inventoryController;

  GameCanvasStatus onCanvasItemClick(Item item) {
    if (item.content == null) {
      //TODO: react -> typeOf keyItem ou collectible
      if (item.setState == null) return GameCanvasStatus.error;

      final tempItem =
          TemporaryItem(setState: item.setState!, image: item.image);
      inventoryController.addTempItem(tempItem);
      return GameCanvasStatus.itemCreatedSuccess;
    }

    final collectible = Collectible(
      id: item.id,
      image: item.image,
      content: CollectibleContent(
        id: item.content!.id,
        type: item.content!.type,
        text: item.content!.text,
        name: item.content!.name,
        image: item.content!.image,
      ),
      requiredState: item.requiredState,
    );
    inventoryController.addCollectible(collectible);
    return GameCanvasStatus.collectibleCreatedSuccess;
  }
}
