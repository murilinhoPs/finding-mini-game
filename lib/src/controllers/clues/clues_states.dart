import 'package:equatable/equatable.dart';
import 'package:finding_mini_game/src/models/clue.dart';

enum CluesStatus { initial, cluesCreatedSuccess, cluesShow, cluesHide, failure }

class CluesStates extends Equatable {
  final CluesStatus status;
  final int currentClueIndex;
  final List<Clues> clues;

  const CluesStates({
    this.status = CluesStatus.initial,
    this.currentClueIndex = 0,
    this.clues = const <Clues>[],
  });

  CluesStates copyWith({
    CluesStatus? status,
    int? currentClueIndex,
    List<Clues>? clues,
  }) {
    return CluesStates(
      status: status ?? this.status,
      currentClueIndex: currentClueIndex ?? this.currentClueIndex,
      clues: clues ?? this.clues,
    );
  }

  @override
  List<Object> get props => [status, currentClueIndex, clues];
}
