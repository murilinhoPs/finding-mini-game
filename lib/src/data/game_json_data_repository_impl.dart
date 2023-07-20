import 'dart:convert';

import 'package:finding_mini_game/src/data/game_data_repository.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/services.dart';

class GameJsonDataRepositoryImpl extends GameDataRepository {
  GameJsonDataRepositoryImpl(super.jsonPath);

  @override
  Future<MiniGameDataModel> loadJson() async {
    final jsonProduct = await rootBundle.loadString(jsonPath);
    final jsonResponse = json.decode(jsonProduct);

    return miniGameData = MiniGameDataModel.fromJson(jsonResponse);
  }
}
