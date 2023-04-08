import 'dart:math' as math;

import 'package:flutter/material.dart';

class InventoryIcons extends StatelessWidget {
  const InventoryIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Icon(
            Icons.key,
            color: Colors.lightBlue[100],
            size: 20.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Transform.rotate(
            angle: math.pi / 6,
            child: Container(
              height: 2.4,
              width: 40,
              color: Colors.lightBlue[50],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40, top: 4.0, bottom: 8.0),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.lightBlue[100],
            size: 20.0,
          ),
        ),
      ],
    );
  }
}
