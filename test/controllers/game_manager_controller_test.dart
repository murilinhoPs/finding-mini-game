import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_states.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_entity.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InventoryController inventoryController;
  late GameManagerController gameManagerController;

  const maxInventoryCapacity = 2;

  const collectibleListMock = [
    Collectible(
      id: '1',
      content: CollectibleContent(
        id: '1:1',
        type: 'document',
        text: 'text',
        name: 'name',
        image: 'collectible1_image.png',
      ),
      image: 'collectible1_image.png',
    ),
    Collectible(
      id: '2',
      content: CollectibleContent(
        id: '1:2',
        type: 'photo',
        text: 'text',
        name: 'name',
        image: 'collectible2_image.png',
      ),
      image: 'collectible2_image.png',
    )
  ];

  group('GameManagerControllerTest: ', () {
    setUp(() {
      inventoryController = InventoryController(
        checkInventoryCapacity: (() {}),
      );
      gameManagerController = GameManagerController(
        inventoryMaxCapacity: maxInventoryCapacity,
        inventoryController: inventoryController,
      );
    });

    test(
        'should return GameManagerLevelComplete() when inventory.collectibles.lenght == maxInventoryCapacity',
        () {
      inventoryController.value = inventoryController.value.copyWith(
        inventory: const InventoryEntity(collectibles: collectibleListMock),
      );
      gameManagerController.gameCompleted();

      expect(gameManagerController.value, const GameManagerLevelComplete());
    });

    test(
        'should return GameManagerLevelIncomplete() when inventory.collectibles.lenght < maxInventoryCapacity',
        () {
      gameManagerController.gameCompleted();

      expect(gameManagerController.value, const GameManagerLevelIncomplete());
    });

    test(
        'should return GameManagerLevelExit() when call gameExited because user left the game unfinished',
        () {
      gameManagerController.gameExited();

      expect(gameManagerController.value, const GameManagerLevelExit());
    });
  });
}
