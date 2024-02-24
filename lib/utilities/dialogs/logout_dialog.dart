import 'package:firetest/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
      context: context,
      title: "Log out",
      content: "Are u sure u want to log out?",
      optionsBuilder: () => {
            "Cancel": false,
            "Log out": true,
          }).then((value) => value ?? false);
}
