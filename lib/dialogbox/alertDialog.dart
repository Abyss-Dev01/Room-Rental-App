import 'package:flutter/material.dart';

class AlertDialogBar extends StatelessWidget {
  final String message;
  const AlertDialogBar({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(message),
        ],
      ),
    );
  }
}
