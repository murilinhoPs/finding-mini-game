import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/models/clue.dart';
import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CluesController cluesController;

  final cluesData = [
    CluesData(
      id: '1',
      time: 10,
      active: true,
      description: 'description1 sem fala do narrador',
    ),
    CluesData(
      id: '2',
      time: 20,
      active: false,
      description: 'description2 sem fala do narrador',
    ),
    CluesData(
      id: '3',
      time: 30,
      active: false,
      description: 'description com fala do narrador',
      narradorLine: 'insira fala do narrador aqui',
    ),
  ];

  const clues = [
    Clues(
      id: '1',
      time: 10,
      active: true,
      description: 'description1 sem fala do narrador',
    ),
    Clues(
      id: '2',
      time: 20,
      active: false,
      description: 'description2 sem fala do narrador',
    ),
    Clues(
      id: '3',
      time: 30,
      active: false,
      description: 'description com fala do narrador',
      narradorLine: 'insira fala do narrador aqui',
    ),
  ];

  group('CluesControllerTests: ', () {
    setUp(() {
      cluesController = CluesController();
      cluesController.createClues(cluesData);
    });

    test('should return cluesCreatedSuccess when call createClues()', () {
      expect(
          cluesController.value,
          CluesStates(
            status: CluesStatus.cluesCreatedSuccess,
            cluesTimeCount: clues.last.time + 1,
            clues: clues,
          ));
    });

    test(
        'should return cluesNotAvailable when call checkAvailibleClue() and received duration is equal one of clues.time',
        () {
      const time = 20;
      cluesController.checkAvailibleClue(time);
      cluesController.clues[1].copyWith(active: true);

      expect(cluesController.status, CluesStatus.cluesAvailable);
      expect(cluesController.clues, cluesController.clues);
      expect(cluesController.clues[1].time, time);
    });

    group('ClueTapTests: ', () {
      test(
          'should return clueNotActive when call onClueTap() and currentClue.active is false',
          () {
        cluesController.onClueTap(1);

        expect(cluesController.status, CluesStatus.clueNotActive);
      });

      test(
          'should return cluesShow when call onClueTap() and currentClue.active is true',
          () {
        const time = 20;
        cluesController.checkAvailibleClue(time);
        cluesController.onClueTap(1);

        expect(cluesController.status, CluesStatus.cluesShow);
        expect(cluesController.currentClueIndex, 1);
      });

      test(
          'should return cluesHide when call onClueTap() twice on same clue and and currentClue narradorLine is null',
          () {
        const time = 20;
        cluesController.checkAvailibleClue(time);
        cluesController.onClueTap(1);

        expect(cluesController.status, CluesStatus.cluesShow);

        cluesController.onClueTap(1);
        expect(cluesController.status, CluesStatus.cluesHide);
        expect(cluesController.currentClueIndex, 1);
      });

      test(
          'should return cluesNarradorLineShow when call onClueTap() twice on same clue and currentClue has a narradorLine',
          () {
        const index = 2;
        const time = 30;
        cluesController.checkAvailibleClue(time);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesShow);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesNarradorLineShow);
        expect(cluesController.currentClueIndex, index);
      });

      test(
          'should return cluesHide when call onClueTap() more than twice on same clue and currentClue narradorLine == state.naradorLine',
          () {
        const index = 2;
        const time = 30;
        cluesController.checkAvailibleClue(time);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesShow);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesNarradorLineShow);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesShow);

        cluesController.onClueTap(index);
        expect(cluesController.status, CluesStatus.cluesHide);
        expect(cluesController.narradorLine, clues[index].narradorLine);
      });
    });

    test('should return cluesHide when call closeClue()', () {
      cluesController.closeClue(0);
      expect(cluesController.status, CluesStatus.cluesHide);
      expect(cluesController.currentClueIndex, 0);
    });
  });

  test('dasd', () {
    var words = "I have 10 items/ and 5 cards/ and 1 assets";

    var newWords = words
        .replaceAll(RegExp(r'\b(items|cards|assets)\b'), '')
        .replaceAll('/', '');

    print(newWords);
  });
}

// - nao esta ativa, return cluesNotAvailable;
// - status não é cluesShow, eu mostro a dica do current index (cluesShow);
// - na dica atual não tiver fala do narrador, ou a fala do narrador é
//igual a fala da dica atual (jogador clicou dnv na mesma dica com fala),
//eu só escondo a dica (cluesHide);
// - mostro a fala do narrador, cluesNarradorLineShow