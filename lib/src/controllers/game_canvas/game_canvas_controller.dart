import 'dart:convert';
import 'dart:ui' as ui;

import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_states.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_states.dart';
import 'package:finding_mini_game/src/models/collectible.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:finding_mini_game/src/models/temporary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameCanvasController extends ValueNotifier<GameCanvasState> {
  GameCanvasController(
    this.inventoryController, {
    this.itemClickFeedback,
    required this.background,
    required this.images,
    required this.items,
  }) : super(const GameCanvasInitial());
  final InventoryController inventoryController;
  final VoidCallback? itemClickFeedback;
  late ui.Image? background;
  late Map<String, ui.Image> images;
  late List<Item> items;

  GameCanvasState get state => value;

  Future loadJson() async {
    final jsonProduct = await rootBundle.loadString('path recebido como param');
    final jsonResponse = json.decode(jsonProduct);
    final miniGameData = MiniGameDataModel.fromJson(jsonResponse);
    items = miniGameData.collectibles;

    //controller para carregar só o json
  }

  Future loadBackground() async {
    final data = await rootBundle.load('miniGameData.background');
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);

    background = image;
  }

  Future loadImages() async {
    List<String> imagePaths;
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifestContent);
    final paths =
        manifestMap.keys.where((String key) => key.contains('.png')).toList();
    imagePaths = paths;

    for (var imagePath in imagePaths) {
      final data = await rootBundle.load(imagePath);
      final bytes = data.buffer.asUint8List();
      final image = await decodeImageFromList(bytes);
      final imageName = imagePath
          .replaceAll('assets/', '')
          .replaceAll('cards/', '')
          .replaceAll('items/', '')
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
