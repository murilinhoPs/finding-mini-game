import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/models/clue.dart';
import 'package:flutter/material.dart';

class CluesController extends ValueNotifier<CluesStates> {
  CluesController() : super(const CluesStates());

  List<Clues> get clues => value.clues;
  CluesStatus get status => value.status;
  int get cluesTimeCount => value.cluesTimeCount;

  void createClues() {}

  void checkAvailibleClue(int duration) {}
}
