import 'package:noteme/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "An error occured!",
    content: text,
    optionsBuilder: () => {
      "OK": null,
    },
  );
}
