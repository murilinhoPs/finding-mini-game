import 'package:flutter/material.dart';

SnackBar showNarradorLine({
  required String text,
  required BuildContext context,
}) {
  return SnackBar(
    content: Text(text),
    showCloseIcon: true,
    closeIconColor: Colors.blueGrey,
  );
}
