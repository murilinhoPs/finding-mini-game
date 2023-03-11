//TODO: vai ter o estado pra exportar pro journal
// inventario temporario, com itens tipo chave....
// que não vão para o journal
// states: Add tempItem add Collectible

import 'package:finding_mini_game/src/models/inventory.dart';
import 'package:flutter/material.dart';

class InventoryController extends ValueNotifier<InventoryModel> {
  InventoryController() : super(const InventoryModel());
}
