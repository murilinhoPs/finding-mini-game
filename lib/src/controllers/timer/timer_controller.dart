import 'dart:async';

import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:flutter/material.dart';

class TimerController extends ValueNotifier<TimerState> {
  TimerController({
    required this.ticker,
    required this.cluesController,
  }) : super(const TimerInitial(60));
  final Ticker ticker;
  final CluesController cluesController;

  StreamSubscription<int>? tickerSubscription;

  @override
  void dispose() {
    tickerSubscription?.cancel();
    super.dispose();
  }

  void startTimer(int duration) {
    value = TimerRunInProgress(duration);
    tickerSubscription?.cancel();
    tickerSubscription =
        ticker.tick().listen((duration) => timerTicked(duration));
  }

  void timerTicked(int duration) {
    if (duration < cluesController.cluesTimeCount) {
      value = TimerRunInProgress(duration);
      cluesController.checkAvailibleClue(duration);
      return;
    }
    value = const TimerRunComplete();
    tickerSubscription?.cancel();
  }

  void timerReset() {
    tickerSubscription?.cancel();
    startTimer(0);
  }

  void timerPaused() {
    if (value is TimerRunInProgress) {
      tickerSubscription?.pause();
      final newValue = TimerRunPause(value.duration);
      value = newValue;
    }
  }

  void timerResumed() {
    if (value is TimerRunPause) {
      tickerSubscription?.resume();
      final newValue = TimerRunInProgress(value.duration);
      value = newValue;
    }
  }
}
