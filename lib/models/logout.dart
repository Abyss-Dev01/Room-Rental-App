// import 'dart:ffi';
// import 'dart:js';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:room_rental_app/pages/loginPage.dart';

// class LogoutFunction extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center();
//   }

//   FirebaseAuth auth = FirebaseAuth.instance;
//   Future<Void> logout() async {
//     auth.signOut().then(
//       (value) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => LoginPage(),
//           ),
//         );
//       },
//     );
//   }
// }
