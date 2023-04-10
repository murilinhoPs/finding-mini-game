import 'package:finding_mini_game/src/controllers/game_canvas/game_canvas_controller.dart';
import 'package:finding_mini_game/src/controllers/inventory/inventory_controller.dart';
import 'package:finding_mini_game/src/view/widgets/inventory/inventory_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsInventory extends StatefulWidget {
  const ItemsInventory({
    required this.inventoryController,
    super.key,
  });
  final InventoryController inventoryController;

  @override
  State<ItemsInventory> createState() => _ItemsInventoryState();
}

class _ItemsInventoryState extends State<ItemsInventory> {
  List<Widget> get collectiblesList => List.generate(
        5,
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
              child: widget.inventoryController.tempItems.length > index
                  ? RawImage(
                      image: context.read<GameCanvasController>().images[
                          widget.inventoryController.tempItems[index].image],
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
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
      child: Column(
        children: [
          const SizedBox(height: 42),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: collectiblesList,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: InventoryIcons(),
          )
        ],
      ),
    );
  }
}
