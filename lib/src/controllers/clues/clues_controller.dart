import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/models/clue.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';

class CluesController extends ValueNotifier<CluesStates> {
  CluesController({
    required this.data,
  }) : super(const CluesStates());
  final List<CluesData> data;

  List<Clues> get clues => value.clues;
  CluesStatus get status => value.status;
  int get cluesTimeCount => value.cluesTimeCount;
  int get currentClueIndex => value.currentClueIndex;
  String? get narradorLine => value.narradorLine;

  int _currentIndex = -1;

  void createClues() {
    final createdClues = [
      ...data.map(
        (clue) => Clues(
          id: clue.id,
          time: clue.time,
          active: clue.active,
          description: clue.description,
          narradorLine: clue.narradorLine,
        ),
      )
    ];

    value = CluesStates(
      status: CluesStatus.cluesCreatedSuccess,
      cluesTimeCount: createdClues.last.time + 1,
      clues: createdClues,
    );
    //TODO:show cluesWidget with updatedValues
  }

  void onClueTap(int clueIndex) {
    final currentClue = clues[clueIndex];

    if (!currentClue.active) {
      value = value.copyWith(
        status: CluesStatus.clueNotActive,
      );
      return;
    }
    if (status == CluesStatus.clueShow && _currentIndex == clueIndex) {
      value = value.copyWith(
        status: CluesStatus.clueHide,
        currentClueIndex: clueIndex,
      );
      _currentIndex = clueIndex;
      return;
    }
    if (currentClue.active && currentClue.narradorLine == null ||
        currentClue.narradorLine != null &&
            narradorLine == currentClue.narradorLine) {
      value = value.copyWith(
        status: CluesStatus.clueShow,
        currentClueIndex: clueIndex,
      );
      _currentIndex = clueIndex;
      return;
    }
    value = value.copyWith(
      status: CluesStatus.cluesNarradorLineShow,
      narradorLine: currentClue.narradorLine,
      currentClueIndex: clueIndex,
    );
    _currentIndex = clueIndex;
  } //TODO:if showState, o widget vai pegar a description e mostrar o valor dela + highlight clueIndex. se clicar dnv, vai sumir -> hideState

  void closeClues() {
    value = value.copyWith(
      status: CluesStatus.cluesClose,
    );
  }

  void onCluesShow() {
    value = value.copyWith(
      status: CluesStatus.cluesOpen,
    );
  }

  void checkAvailibleClue(int duration) {
    for (var index = 0; index < clues.length; index++) {
      if (clues[index].time <= duration) {
        final updatedClue = clues[index].copyWith(
          active: true,
        );
        value = value.copyWith(
          clues: List.of(clues)..replaceRange(index, index + 1, [updatedClue]),
        );
      }
    }
  }
}
