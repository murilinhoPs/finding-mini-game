import 'package:finding_mini_game/src/controllers/timer/timer_controller.dart';
import 'package:finding_mini_game/src/controllers/timer/timer_states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerDebug extends StatelessWidget {
  const TimerDebug({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerController = context.watch<TimerController>();
    final state = timerController.value;
    final minutesStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state is TimerInitial) ...[
          ElevatedButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => timerController.startTimer(),
          ),
        ],
        Text(
          'timer: $minutesStr:$secondsStr',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: FloatingActionButton(
            backgroundColor:
                state is TimerRunComplete ? Colors.lightGreen : Colors.red,
            child: const Icon(
              Icons.restore,
              size: 14,
            ),
            onPressed: () => timerController.timerReset(),
          ),
        ),
      ],
    );
  }
}
