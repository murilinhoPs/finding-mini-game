import 'package:equatable/equatable.dart';

abstract class GameCanvasState extends Equatable {
  const GameCanvasState();

  @override
  List<Object?> get props => [];
}

class GameCanvasInitial extends GameCanvasState {
  const GameCanvasInitial();
}

class GameCanvasLoading extends GameCanvasState {
  const GameCanvasLoading();
}

class GameCanvasSuccess extends GameCanvasState {
  const GameCanvasSuccess();
}

class GameCanvasItemCreatedSuccess extends GameCanvasState {
  const GameCanvasItemCreatedSuccess();
}

class GameCanvasItemCreatedFailure extends GameCanvasState {
  const GameCanvasItemCreatedFailure();
}

class GameCanvasCollectibleAddSuccess extends GameCanvasState {
  const GameCanvasCollectibleAddSuccess();
}

class GameCanvasCollectibleAddFailure extends GameCanvasState {
  const GameCanvasCollectibleAddFailure();
}
