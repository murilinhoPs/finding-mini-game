import 'package:equatable/equatable.dart';

abstract class GameCanvasState extends Equatable {
  const GameCanvasState();
}

class GameCanvasInitial extends GameCanvasState {
  const GameCanvasInitial();

  @override
  List<Object?> get props => [];
}

class GameCanvasItemCreatedSuccess extends GameCanvasState {
  const GameCanvasItemCreatedSuccess();

  @override
  List<Object?> get props => [];
}

class GameCanvasItemCreatedFailure extends GameCanvasState {
  const GameCanvasItemCreatedFailure();

  @override
  List<Object?> get props => [];
}

class GameCanvasCollectibleAddSuccess extends GameCanvasState {
  const GameCanvasCollectibleAddSuccess();

  @override
  List<Object?> get props => [];
}

class GameCanvasCollectibleAddFailure extends GameCanvasState {
  const GameCanvasCollectibleAddFailure();

  @override
  List<Object?> get props => [];
}
