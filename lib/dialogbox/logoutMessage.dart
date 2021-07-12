import 'package:flutter/material.dart';
import 'package:room_rental_app/pages/loginPage.dart';

class LogoutAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: Text('Logout'),
        onPressed: () {
          showAlertDialog(context);
          final snackBar = SnackBar(content: Text('Successfully logged out'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Authentication Alert"),
      content: Text("You are to be logged out"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
