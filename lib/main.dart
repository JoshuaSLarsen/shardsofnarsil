import 'package:flutter/material.dart';
import './navigation/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shards of Narsil',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey[600],
          minWidth: 1,
          textTheme: ButtonTextTheme.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        fontFamily: 'Exo 2',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0),
          title: TextStyle(fontSize: 20.0),
          body1: TextStyle(fontSize: 13.0),
          button: TextStyle(color: Colors.white),
        ),
        primaryColor: Colors.blueGrey[600],
        primaryColorDark: Colors.black,
        accentColor: Colors.grey[200],

        scaffoldBackgroundColor: Colors.grey[300],
        bottomAppBarColor: Colors.blueGrey[600],
        hintColor: Colors.grey[500],
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.red[800],
          elevation: 300),
      ),
      home: Home(),
    );
  }
}
