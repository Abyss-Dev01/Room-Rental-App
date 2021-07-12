import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_rental_app/constants.dart';
import 'package:room_rental_app/dialogbox/alertDialog.dart';
import 'package:room_rental_app/models/authentication.dart';
import 'package:room_rental_app/pages/loginPage.dart';
import 'package:room_rental_app/screens/mainScreen.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
      );
      AlertDialogBar(
        message: "Registered successfully",
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 34,
                          foreground: Paint()..shader = mainTextGradient,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hi,\nPlease fill up the form for account registration.",
                        style: TextStyle(
                          fontSize: 24,
                          foreground: Paint()..shader = subTextGradient,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  //autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //email
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter Email here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty || !value.contains("@")) {
                            return "Invalid Email";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //password
                      TextFormField(
                        controller: _pass,
                        decoration: InputDecoration(
                          hintText: "Enter password here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length <= 6) {
                            return "Invalid Password";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //confirm password
                      TextFormField(
                        controller: _confirmpass,
                        decoration: InputDecoration(
                          hintText: "Confirm password here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blue[200],
                          ),
                        ),
                        validator: (value) {
                          if (value.length <= 6 || value.isEmpty) {
                            return "Invalid Password";
                          } else if (value != _pass.text) {
                            return "Password doesn't match";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: Text("Sign up"),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          _submit();
                          print("$_email");
                          print("$_pass");
                          print("$_confirmpass");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Already have an account?"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Click here to login",
                          style: TextStyle(
                            foreground: Paint()..shader = noticeTextGradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
