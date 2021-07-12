import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:room_rental_app/constants.dart';
import 'package:room_rental_app/models/authentication.dart';
import 'package:room_rental_app/pages/registrationPage.dart';
import 'package:room_rental_app/screens/mainScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isHidden = true;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

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
          .logIn(_authData['email'], _authData['password']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 34,
                        foreground: Paint()..shader = mainTextGradient,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hi,\nWelcome to room rental app",
                      style: TextStyle(
                        fontSize: 24,
                        foreground: Paint()..shader = subTextGradient,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                          if (value.isEmpty || !value.contains('@')) {
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
                        height: 20,
                      ),
                      //password
                      TextFormField(
                        controller: _password,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          hintText: "Enter password here",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blue[200],
                          ),
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                        height: 60,
                      ),
                      ElevatedButton(
                        child: Text("Login"),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                          _submit();
                          print("$_email");
                          print("$_password");
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Don't have an account?"),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                        child: Text(
                          "Click here to register",
                          style: TextStyle(
                            foreground: Paint()..shader = noticeTextGradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
