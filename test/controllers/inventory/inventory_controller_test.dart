import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InventoryControllerTest:', () {
    late InventoryController inventoryController;

    const itemToAddMock = TemporaryItem(
      setState: {
        'key': true,
      },
      image: 'item1_image.png',
    );
    const itemsListMock = [
      TemporaryItem(
        setState: {
          'código': true,
        },
        image: 'item2_image.png',
      ),
      itemToAddMock,
    ];

    final collectibleMock = Collectible(
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

    final collectibleListMock = [
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
      collectibleMock,
    ];

    setUp(() {
      inventoryController = InventoryController();
    });

    test(
        'should return initial state when initializing InventoryController and empty lists',
        () {
      expect(inventoryController.status, InventoryStatus.initial);
      expect(inventoryController.collectibles, []);
      expect(inventoryController.tempItems, []);
    });

    group('Colletible tests:', () {
      test(
          'should return collectibleAddSuccess state when calling addCollectible() from controller and return a list with one collectible',
          () {
        inventoryController.addCollectible(collectibleMock);

        expect(
            inventoryController.status, InventoryStatus.collectibleAddSuccess);
        expect(inventoryController.collectibles, [collectibleMock]);
      });

      test(
          'should return collectibleAddSuccess state when calling addCollectible() from controller and return a list of collectibles',
          () {
        inventoryController.addCollectible(collectibleListMock[0]);
        inventoryController.addCollectible(collectibleMock);

        expect(
            inventoryController.status, InventoryStatus.collectibleAddSuccess);
        expect(inventoryController.collectibles, collectibleListMock);
      });
    });

    group('TemporaryItems tests:', () {
      test(
          'should return itemAddSuccess state when calling addTempItem() from controller and return a list with one tempItem',
          () {
        inventoryController.addTempItem(itemToAddMock);

        expect(inventoryController.status, InventoryStatus.itemAddSuccess);
        expect(inventoryController.tempItems, [itemToAddMock]);
      });

      test(
          'should return itemAddSuccess state when calling addTempItem() from controller and return a list of tempItems',
          () {
        inventoryController.addTempItem(itemsListMock[0]);
        inventoryController.addTempItem(itemToAddMock);

        expect(inventoryController.status, InventoryStatus.itemAddSuccess);
        expect(inventoryController.tempItems, itemsListMock);
      });

      test(
          'should return itemRemoveSuccess state when calling removeTempItem() from controller and return a list with one tempItem',
          () {
        inventoryController.addTempItem(itemsListMock[0]);
        inventoryController.addTempItem(itemToAddMock);
        inventoryController.removeTempItem(itemsListMock[0]);

        expect(inventoryController.status, InventoryStatus.itemRemoveSuccess);
        expect(inventoryController.tempItems, [itemToAddMock]);
      });
    });
  });
}