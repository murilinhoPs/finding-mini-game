import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/controllers/timer/ticker.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTicker extends Mock implements Ticker {}

void main() {
  late Ticker ticker;
  late CluesController cluesController;
  late TimerController timerController;

  setUpAll(() {
    registerFallbackValue(_MockTicker());
  });

  group('TimerControllerTests: ', () {
    setUp(() {
      ticker = _MockTicker();
      cluesController = CluesController(data: []);
      timerController = TimerController(cluesController: cluesController);
      cluesController.value = const CluesStates(cluesTimeCount: 6);

      when(() => ticker.tick()).thenAnswer(
        (_) => Stream<int>.fromIterable([1, 2, 3, 4, 5]),
      );
    });

    test('should return initial state TimerInitial(60)', () {
      expect(
        timerController.value,
        const TimerInitial(60),
      );
    });

    test('should return TimerRunInProgress 5 times, the cluesTimeCount', () {
      timerController.startTimer();

      expect(timerController.value, const TimerRunInProgress(0));
      verify(() => ticker.tick()).called(1);
    });

    test(
        'should return TimerRunComplete when current duration > cluesTimeCount',
        () {
      timerController.startTimer();
      timerController.timerTicked(cluesController.cluesTimeCount + 1);

      expect(timerController.value, const TimerRunComplete());
      verify(() => ticker.tick()).called(1);
    });

    test('should return TimerInitial when reset timer to zero', () {
      timerController.timerReset();

      expect(timerController.value, const TimerRunInProgress(0));
    });
  });
}
