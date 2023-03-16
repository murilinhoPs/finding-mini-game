import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/models/clue.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';

class CluesController extends ValueNotifier<CluesStates> {
  CluesController() : super(const CluesStates());

  List<Clues> get clues => value.clues;
  CluesStatus get status => value.status;
  int get cluesTimeCount => value.cluesTimeCount;
  int get currentClueIndex => value.currentClueIndex;

  void createClues(List<CluesData> data) {
    value.clues.addAll(
      data.map(
        (clue) => Clues(
          id: clue.id,
          time: clue.time,
          active: clue.active,
          description: clue.description,
          narradorLine: clue.narradorLine,
        ),
      ),
    );
    value = value.copyWith(
      status: CluesStatus.cluesCreatedSuccess,
      cluesTimeCount: clues.last.time + 1,
    );
    notifyListeners(); //TODO:show cluesWidget with updatedValues
  }

  void onClueTap(int clueIndex) {
    if (clues[clueIndex].active) {
      value = value.copyWith(
        status: CluesStatus.cluesShow,
        currentClueIndex: clueIndex,
      );
      return;
    }
    value = value.copyWith(
      status: CluesStatus.cluesHide,
      currentClueIndex: clueIndex,
    );
  }
  //TODO:if showState, o widget vai pegar a description e mostrar o valor dela + highlight clueIndex. se clicar dnv, vai sumir -> hideState

  void checkAvailibleClue(int duration) {
    for (var index = 0; index < clues.length; index++) {
      if (clues[index].time >= duration) {
        final updatedClue = clues[index].copyWith(
          active: true,
        );
        value = value.copyWith(
          status: CluesStatus.cluesAvailable,
          clues: List.of(clues)..replaceRange(index, index + 1, [updatedClue]),
        );
      }
    }
  }
}
