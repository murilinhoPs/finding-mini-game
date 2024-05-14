import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InventoryController inventoryController;

  const itemWithKeyState = TemporaryItem(
    setState: {"key": true},
    image: 'image',
  );

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

  const collectibleWithStateMock = Collectible(
    id: '1',
    content: CollectibleContent(
      id: '1:1',
      type: 'document',
      text: 'text',
      name: 'name',
      image: 'collectible1_image.png',
    ),
    requiredState: {"key": true},
    image: 'collectible1_image.png',
  );

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
    collectibleMock,
  ];

  group('InventoryControllerTest:', () {
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

      test(
          'should return collectibleAddFailure state when calling addCollectible() and it has a requiredState that dont exists on keyItems and return empty list',
          () {
        inventoryController.addCollectible(collectibleWithStateMock);

        expect(
            inventoryController.status, InventoryStatus.collectibleAddFailure);
        expect(inventoryController.collectibles, []);
      });

      test(
          'should return collectibleAddFailure state when calling addCollectible() and it has one requiredState that dont exists on keyItems and other that exists',
          () {
        inventoryController.addTempItem(itemWithKeyState);
        inventoryController.addCollectible(const Collectible(
          id: '1',
          content: CollectibleContent(
            id: '1:1',
            type: 'document',
            text: 'text',
            name: 'name',
            image: 'collectible1_image.png',
          ),
          requiredState: {
            "key": true,
            "a": true,
          },
          image: 'collectible1_image.png',
        ));

        expect(
            inventoryController.status, InventoryStatus.collectibleAddFailure);
        expect(inventoryController.collectibles, []);
      });

      test(
          'should return itemRemoveCollectibeAddSuccess state when calling addCollectible() and it has a requiredState that exists on keyItems and return a list with one collectible',
          () {
        inventoryController.addTempItem(itemWithKeyState);
        inventoryController.addCollectible(collectibleWithStateMock);

        expect(inventoryController.status,
            InventoryStatus.itemRemoveCollectibeAddSuccess);
        expect(inventoryController.collectibles, [collectibleWithStateMock]);
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
          'should return itemUpdateFailure state when calling addTempItem() and the keyItems already have that value',
          () {
        inventoryController.updateKeyItems(itemWithKeyState);
        inventoryController.addTempItem(itemToAddMock);

        expect(inventoryController.status, InventoryStatus.itemUpdateFailure);
        expect(inventoryController.tempItems, []);
      });

      test(
          'should return itemUpdateFailure state when calling removeTempItem() and try to remove the keyItems that dont exists',
          () {
        inventoryController.removeTempItem(collectibleWithStateMock);

        expect(inventoryController.status, InventoryStatus.itemUpdateFailure);
        expect(inventoryController.tempItems, []);
      });

      test(
          'should return itemRemoveSuccess state when calling removeTempItem() from controller and return a list with one tempItem',
          () {
        inventoryController.addTempItem(itemsListMock[0]);
        inventoryController.addTempItem(itemToAddMock);
        inventoryController.removeTempItem(collectibleWithStateMock);

        expect(inventoryController.status,
            InventoryStatus.itemRemoveCollectibeAddSuccess);
        expect(inventoryController.tempItems, [itemsListMock[0]]);
      });
    });
  });
}
