// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:finding_mini_game/src/controllers/clues/clues_controller.dart';
import 'package:finding_mini_game/src/controllers/clues/clues_states.dart';
import 'package:finding_mini_game/src/view/widgets/narrador_line_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CluesWidget extends StatefulWidget {
  const CluesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CluesWidget> createState() => _CluesWidgetState();
}

class _CluesWidgetState extends State<CluesWidget> {
  late CluesController cluesController;

  bool get selectedHelp =>
      cluesController.status == CluesStatus.cluesClose ||
      cluesController.status == CluesStatus.cluesCreatedSuccess;

  bool get showCluesOptions =>
      cluesController.status != CluesStatus.cluesClose &&
      cluesController.status != CluesStatus.cluesCreatedSuccess;

  bool get showClueDescription =>
      cluesController.status == CluesStatus.clueShow ||
      cluesController.status == CluesStatus.cluesNarradorLineShow;

  bool selectedClue(int index) =>
      (cluesController.status == CluesStatus.clueShow ||
          cluesController.status == CluesStatus.cluesNarradorLineShow) &&
      index == cluesController.currentClueIndex;

  void showNarrador() {
    if (cluesController.status == CluesStatus.cluesNarradorLineShow) {
      final text = cluesController.narradorLine;
      ScaffoldMessenger.of(context).showSnackBar(
        showNarradorLine(
          context: context,
          text: text ?? '',
        ),
      );
    }
  }

  void clueTapCallback(int index) {
    cluesController.onClueTap(index);
    showNarrador();
  }

  void onCluesShowCallback() {
    if (selectedHelp) {
      cluesController.onCluesShow();
      return;
    }
    cluesController.closeClues();
  }

  @override
  void initState() {
    cluesController = context.watch<CluesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: !selectedHelp ? Colors.black45 : null,
      padding: const EdgeInsets.fromLTRB(12.0, 16.0, 2.0, 0.0),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: selectedHelp ? MainAxisSize.min : MainAxisSize.max,
        children: [
          IconButton(
            isSelected: selectedHelp,
            selectedIcon: Icon(
              Icons.help_center_outlined,
              color: Colors.lightBlue[100],
            ),
            icon: Icon(
              Icons.help_center,
              color: Colors.lightBlue[100],
            ),
            onPressed: onCluesShowCallback,
          ),
          if (showCluesOptions)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 16),
                      ...cluesController.clues.mapIndexed(
                        (index, clue) => MaterialButton(
                          height: 28,
                          minWidth: 20,
                          elevation: 0.0,
                          disabledColor: Colors.grey[600]!.withOpacity(0.8),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: selectedClue(index)
                              ? Colors.lightBlue[100]
                              : Colors.blueGrey,
                          textColor: selectedClue(index)
                              ? Colors.grey[800]
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed:
                              clue.active ? () => clueTapCallback(index) : null,
                          child: Text(
                            clue.id,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                    ],
                  ),
                  if (showClueDescription)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        cluesController.clues[cluesController.currentClueIndex]
                            .description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
