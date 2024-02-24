import 'package:firetest/ulities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: "Delete",
      content: "Are u sure u want to delete this item?",
      optionsBuilder: () => {
            "Cancel": false,
            "Yes": true,
          }).then((value) => value ?? false);
}
