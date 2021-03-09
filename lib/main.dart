import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/common/styles.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/provider/list_provider.dart';
import 'package:rest_o/screens/details_screen.dart';
import 'package:rest_o/screens/home_screen.dart';

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
        primaryColor: primaryColor,
        accentColor: secondaryColor,
      ),
      routes: {
        HomeScreen.id: (context) => ChangeNotifierProvider<ListProvider>(
            create: (context) => ListProvider(apiHelper: ApiHelper()),
            child: HomeScreen()),
        DetailsScreen.id: (context) => DetailsScreen(
              restaurantId: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
