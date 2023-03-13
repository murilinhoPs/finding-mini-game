import 'package:finding_mini_game/src/controllers/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CanvasControllerTest: ', () {
    late InventoryController inventoryController;
    late GameCanvasController canvasController;

    final itemWithoutContentMock = Item(
      id: 'id',
      x: 1200.2,
      y: 80.4,
      image: 'item1_image.png',
      show: true,
      setState: {
        'key': true,
      },
    );

    final itemWithError = Item(
      id: 'id33',
      x: 200.2,
      y: 80.4,
      image: 'item_image.png',
      show: true,
    );

    final itemWithContentMock = Item(
      id: '1',
      x: 800.2,
      y: 40.4,
      image: 'collectible1_image.png',
      show: true,
      content: Content(
        id: '1:1',
        type: 'document',
        text: 'text',
        name: 'name',
        image: 'collectible1_image.png',
      ),
    );

    const itemToAddMock = TemporaryItem(
      setState: {
        'key': true,
      },
      image: 'item1_image.png',
    );

    const collectibleMock = Collectible(
      id: '1',
      content: CollectibleContent(
        id: '1:1',
        type: 'document',
        text: 'text',
        name: 'name',
        image: 'collectible1_image.png',
      ),
      image: 'collectible1_image.png',
    );

    setUp(() {
      inventoryController = InventoryController();
      canvasController = GameCanvasController(inventoryController);
    });

    test(
        'should return GameCanvasStatus.error when there is an error bc content and setState are null',
        () {
      final status = canvasController.onCanvasItemClick(itemWithError);

      expect(status, GameCanvasStatus.error);
    });

    test(
        'should return GameCanvasStatus.itemCreatedSuccess when there is an item without content and setState',
        () {
      final status = canvasController.onCanvasItemClick(itemWithoutContentMock);

      expect(status, GameCanvasStatus.itemCreatedSuccess);
      expect(inventoryController.tempItems, [itemToAddMock]);
      expect(inventoryController.keyItems, [itemToAddMock.setState.keys.first]);
    });

    test(
        'should return GameCanvasStatus.collectibleCreatedSuccess when there is an item with content',
        () {
      final status = canvasController.onCanvasItemClick(itemWithContentMock);

      expect(status, GameCanvasStatus.collectibleCreatedSuccess);
      expect(inventoryController.collectibles, [collectibleMock]);
    });
  });
}
