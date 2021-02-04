import 'package:flutter/material.dart';
import 'package:rest_o/common/styles.dart';
import 'package:rest_o/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest-O',
      initialRoute: HomeScreen.id,
      theme: ThemeData(
        textTheme: textTheme,
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
