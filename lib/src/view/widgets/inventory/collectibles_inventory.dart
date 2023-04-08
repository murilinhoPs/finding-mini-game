import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectiblesInventory extends StatefulWidget {
  const CollectiblesInventory({
    required this.inventoryController,
    super.key,
  });
  final InventoryController inventoryController;

  @override
  State<CollectiblesInventory> createState() => _CollectiblesInventoryState();
}

class _CollectiblesInventoryState extends State<CollectiblesInventory> {
  List<Widget> get collectiblesList => List.generate(
        10,
        (index) => SizedBox(
          height: 32,
          width: 32,
          child: Container(
            color: Colors.blueGrey[800],
            padding: const EdgeInsets.all(3.2),
            child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
              ),
              child: widget.inventoryController.collectibles.length > index
                  ? RawImage(
                      image: context.read<GameCanvasController>().images[
                          widget.inventoryController.collectibles[index].image],
                    )
                  : null,
            ),
          ),
        ),
      ).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[700],
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: collectiblesList,
      ),
    );
  }
}
