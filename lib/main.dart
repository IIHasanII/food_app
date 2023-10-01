import 'package:flutter/material.dart';
import 'package:food_app/features/home/ui/home_screen.dart';
import 'package:food_app/features/login/ui/login.dart';
import 'package:food_app/features/signup/ui/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromARGB(255, 18, 231, 128),
              ),
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue)),
      initialRoute: Signup.id,
      routes: {
        Signup.id: (context) => Signup(),
        HomeScreen.id: (context) => HomeScreen(),
        //SelectedItem.id:(context) => SelectedItem(selectedItem: null,),
        Login.id: (context) => Login(),
      },
    );
  }
}
