import 'package:equatable/equatable.dart';
import 'package:finding_mini_game/src/models/clue.dart';

enum CluesStatus {
  initial,
  cluesCreatedSuccess,
  cluesAvailable,
  cluesNotAvailable,
  clueNotActive,
  clueShow,
  cluesHide,
  cluesOpen,
  cluesNarradorLineShow,
  failure
}

class CluesStates extends Equatable {
  final CluesStatus status;
  final int cluesTimeCount;
  final int currentClueIndex;
  final List<Clues> clues;
  final String? narradorLine;

  const CluesStates({
    this.status = CluesStatus.initial,
    this.currentClueIndex = 0,
    this.cluesTimeCount = 0,
    this.clues = const <Clues>[],
    this.narradorLine,
  });

  CluesStates copyWith({
    CluesStatus? status,
    int? currentClueIndex,
    int? cluesTimeCount,
    List<Clues>? clues,
    String? narradorLine,
  }) {
    return CluesStates(
      status: status ?? this.status,
      currentClueIndex: currentClueIndex ?? this.currentClueIndex,
      cluesTimeCount: cluesTimeCount ?? this.cluesTimeCount,
      clues: clues ?? this.clues,
      narradorLine: narradorLine ?? this.narradorLine,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentClueIndex,
        clues,
        cluesTimeCount,
        narradorLine,
      ];
}
