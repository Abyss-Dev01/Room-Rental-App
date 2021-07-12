import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:room_rental_app/models/httpException.dart';

class Authentication with ChangeNotifier {
  Future<void> signUp(String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDo7G3WeHyy4UugRFc3Y2kFBuOYYIvOUbs"),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
//      print(responseData);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> logIn(String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDo7G3WeHyy4UugRFc3Y2kFBuOYYIvOUbs'),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
//      print(responseData);

    } catch (error) {
      throw error;
    }
  }
}
