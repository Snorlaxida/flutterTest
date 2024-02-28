import 'package:noteme/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: "Sharing",
    content: "You can not share empty note!",
    optionsBuilder: () => {
      "OK": null,
    },
  );
}
