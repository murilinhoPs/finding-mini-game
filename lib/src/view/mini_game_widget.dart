import 'dart:ui' as ui;

import 'package:finding_mini_game/src/models/mini_game_data.dart';
import 'package:flutter/material.dart';

class MiniGameWidget extends StatefulWidget {
  final String imagePath;
  final String miniGameJsonpath;
  final List<String>? imagesPath;
  const MiniGameWidget({
    Key? key,
    required this.imagePath,
    required this.imagesPath,
    required this.miniGameJsonpath,
  }) : super(key: key);

  @override
  State<MiniGameWidget> createState() => _MiniGameWidgetState();
}

class _MiniGameWidgetState extends State<MiniGameWidget> {
  late Map<String, ui.Image> images;
  late ui.Image background;
  late MiniGameDataModel miniGame;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
