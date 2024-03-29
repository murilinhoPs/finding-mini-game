import 'package:equatable/equatable.dart';

abstract class GameManagerState extends Equatable {
  const GameManagerState();

  @override
  List<Object?> get props => [];
}

class GameManagerInitial extends GameManagerState {
  const GameManagerInitial();
}

class GameManagerLevelComplete extends GameManagerState {
  const GameManagerLevelComplete();
}

class GameManagerLevelIncomplete extends GameManagerState {
  const GameManagerLevelIncomplete();
}

class GameManagerLevelExit extends GameManagerState {
  const GameManagerLevelExit();
}
