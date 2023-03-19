import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_states.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui' as ui;

void main() {
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
  final itemWithContentAndStateMock = Item(
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
    requiredState: {
      'key': true,
    },
  );

  const itemToAddMock = TemporaryItem(
    setState: {
      'key': true,
    },
    image: 'item1_image.png',
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
    image: 'collectible1_image.png',
    requiredState: {
      'key': true,
    },
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

  group('CanvasControllerTest: ', () {
    setUp(() {
      inventoryController = InventoryController(
        checkInventoryCapacity: (() {}),
      );
      canvasController = GameCanvasController(
        inventoryController,
        backgroundPath: '',
        items: [],
      );
    });

    test(
        'should return GameCanvasItemCreatedFailure()when there is an error bc content and setState are null',
        () {
      canvasController.onCanvasItemClick(itemWithError);

      expect(canvasController.state, const GameCanvasItemCreatedFailure());
    });

    test(
        'should return GameCanvasItemCreatedSuccess() when there is an item without content and setState',
        () {
      canvasController.onCanvasItemClick(itemWithoutContentMock);

      expect(canvasController.state, const GameCanvasItemCreatedSuccess());
      expect(inventoryController.tempItems, [itemToAddMock]);
      expect(inventoryController.keyItems, [itemToAddMock.setState.keys.first]);
    });

    test(
        'should return GameCanvasCollectibleAddSuccess() when there is an item with content',
        () {
      canvasController.onCanvasItemClick(itemWithContentMock);

      expect(canvasController.state, const GameCanvasCollectibleAddSuccess());
      expect(inventoryController.collectibles, [collectibleMock]);
    });

    test(
        'should return GameCanvasCollectibleAddFailure() when tap on item that has a requiredState that dont exists yet',
        () {
      canvasController.onCanvasItemClick(itemWithContentAndStateMock);

      expect(canvasController.value, const GameCanvasCollectibleAddFailure());
      expect(inventoryController.collectibles, []);
    });

    test(
        'should return GameCanvasCollectibleAddSuccess() when tap on item with a valid requiredState',
        () {
      inventoryController.addTempItem(itemToAddMock);

      canvasController.onCanvasItemClick(itemWithContentAndStateMock);

      expect(canvasController.value, const GameCanvasCollectibleAddSuccess());
      expect(inventoryController.collectibles, [collectibleWithStateMock]);
    });
  });
}
