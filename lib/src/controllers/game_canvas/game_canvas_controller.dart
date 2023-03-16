import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_states.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';

class GameCanvasController extends ValueNotifier<GameCanvasState> {
  GameCanvasController(
    this.inventoryController, {
    this.itemClickFeedback,
  }) : super(const GameCanvasInitial());
  final InventoryController inventoryController;
  final VoidCallback? itemClickFeedback;

  GameCanvasState get state => value;

  onCanvasItemClick(Item item) {
    if (item.content == null) {
      //TODO: react -> typeOf keyItem ou collectible
      if (item.setState == null) {
        value = const GameCanvasItemCreatedFailure();
        return;
      }

      final tempItem = TemporaryItem(
        setState: item.setState!,
        image: item.image,
      );
      inventoryController.addTempItem(tempItem);
      value = const GameCanvasItemCreatedSuccess();
      return;
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
    if (inventoryController.status == InventoryStatus.collectibleAddFailure) {
      value = const GameCanvasCollectibleAddFailure();
      return;
    }
    value = const GameCanvasCollectibleAddSuccess();
  }
}
