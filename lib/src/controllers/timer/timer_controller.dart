import 'dart:async';

import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:flutter/material.dart';

class TimerController extends ValueNotifier<TimerState> {
  TimerController({
    required this.ticker,
    required this.cluesController,
  }) : super(const TimerInitial(0));
  final Ticker ticker;
  final CluesController cluesController;

  StreamSubscription<int>? tickerSubscription;

  @override
  void dispose() {
    tickerSubscription?.cancel();
    super.dispose();
  }

  void startTimer(int time) {
    value = TimerRunInProgress(time);
    tickerSubscription?.cancel();
    tickerSubscription =
        ticker.tick(maxTicks: 1).listen((duration) => timerTicked(duration));
    notifyListeners();
  }

  void timerTicked(int duration) {
    if (duration < cluesController.cluesTimeCount) {
      value = TimerRunInProgress(duration);
      cluesController.checkAvailibleClue(duration);
      notifyListeners();
      return;
    }
    value = const TimerRunComplete();
    notifyListeners();
  }

  void timerReset() {
    tickerSubscription?.cancel();
    value = const TimerInitial(0);
  }

  void timerPaused() {
    if (value is TimerRunInProgress) {
      tickerSubscription?.pause();
      final newValue = TimerRunPause(value.duration);
      value = newValue;
      notifyListeners();
    }
  }

  void timerResumed() {
    if (value is TimerRunPause) {
      tickerSubscription?.resume();
      final newValue = TimerRunInProgress(value.duration);
      value = newValue;
      notifyListeners();
    }
  }
}
