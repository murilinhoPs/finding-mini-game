import 'dart:convert';

import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/services.dart';

class GameJsonData {
  GameJsonData(this.jsonPath);
  final String jsonPath;

  late MiniGameDataModel miniGameData;

  List<Item> get items => miniGameData.collectibles;
  List<CluesData> get cluesData => miniGameData.clues;

  Future<MiniGameDataModel> loadJson() async {
    final jsonProduct = await rootBundle.loadString(jsonPath);
    final jsonResponse = json.decode(jsonProduct);

    return miniGameData = MiniGameDataModel.fromJson(jsonResponse);
  }
}
