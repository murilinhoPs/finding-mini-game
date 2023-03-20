import 'dart:convert';
import 'dart:ui' as ui;

import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_states.dart';
import 'package:finding_mini_game/src/controllers/game_manager/game_manager_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameCanvasController extends ValueNotifier<GameCanvasState> {
  GameCanvasController({
    this.itemClickFeedback,
    required this.inventoryController,
    required this.gameManagerController,
    required this.items,
    required this.backgroundPath,
  }) : super(const GameCanvasInitial());
  final InventoryController inventoryController;
  final GameManagerController gameManagerController;
  final VoidCallback? itemClickFeedback;
  final String backgroundPath;
  final List<Item> items;

  ui.Image? background;
  Map<String, ui.Image> images = {};

  GameCanvasState get state => value;

  Future loadBackground() async {
    final data = await rootBundle.load(backgroundPath);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    background = image;
  }

  Future loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifestContent);
    final paths = manifestMap.keys
        .where((String key) =>
            key.contains('.png') && !key.contains('backgrounds'))
        .toList() as List<String>;

    for (var imagePath in paths) {
      final data = await rootBundle.load(imagePath);
      final bytes = data.buffer.asUint8List();
      final image = await decodeImageFromList(bytes);
      final imageName = imagePath
          .replaceAll('/', ' ')
          .replaceAll(RegExp(r'(items|cards|assets)'), '')
          .replaceAll(' ', '')
          .replaceAll('.png', '');

      images.addAll({imageName: image});
    }
  }

  void initCanvas() async {
    value = const GameCanvasLoading();
    await loadBackground();
    await loadImages();
    value = const GameCanvasSuccess();
  }

  void onCanvasItemClick(Item item) {
    print(items.indexOf(item));

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
      items.removeAt(items.indexOf(item));
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
    items.removeAt(items.indexOf(item));
    value = const GameCanvasCollectibleAddSuccess();
  }
}
