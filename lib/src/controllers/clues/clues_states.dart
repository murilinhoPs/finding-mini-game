import 'package:equatable/equatable.dart';
import 'package:finding_mini_game/src/models/clue.dart';

enum CluesStatus { initial, cluesCreatedSuccess, failure }

class CluesStates extends Equatable {
  final CluesStatus status;
  final int cluesTimeCount;
  final List<Clues> clues;

  const CluesStates({
    this.status = CluesStatus.initial,
    this.cluesTimeCount = 0,
    this.clues = const <Clues>[],
  });

  CluesStates copyWith({
    CluesStatus? status,
    int? cluesTimeCount,
    List<Clues>? clues,
  }) {
    return CluesStates(
      status: status ?? this.status,
      cluesTimeCount: cluesTimeCount ?? this.cluesTimeCount,
      clues: clues ?? this.clues,
    );
  }

  @override
  List<Object> get props => [status, cluesTimeCount, clues];
}
