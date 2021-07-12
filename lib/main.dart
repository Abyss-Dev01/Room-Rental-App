import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_rental_app/models/authentication.dart';
import 'package:room_rental_app/pages/loginPage.dart';
import 'package:room_rental_app/services/manageData.dart';
import 'package:room_rental_app/services/maps.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Authentication(),
          ),
          ChangeNotifierProvider.value(
            value: ManageData(),
          ),
          ChangeNotifierProvider.value(
            value: GenerateMaps(),
          )
        ],
        child: MaterialApp(
          title: "Room Rental App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.blue),
          home: LoginPage(),
        ));
  }
}
