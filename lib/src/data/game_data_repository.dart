import 'package:finding_mini_game/src/models/mini_game_data.dart';

abstract class GameDataRepository {
  GameDataRepository(this.jsonPath);
  final String jsonPath;

  late MiniGameDataModel miniGameData;
  List<Item> get items => miniGameData.collectibles;
  List<CluesData> get cluesData => miniGameData.clues;

  Future<MiniGameDataModel> loadJson();
}
