import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/common/styles.dart';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/provider/details_provider.dart';
import 'package:rest_o/provider/favorites_provider.dart';
import 'package:rest_o/provider/list_provider.dart';
import 'package:rest_o/provider/settings_provider.dart';
import 'package:rest_o/screens/details_screen.dart';
import 'package:rest_o/screens/favorites_screen.dart';
import 'package:rest_o/screens/home_screen.dart';
import 'package:rest_o/screens/settings_screen.dart';
import 'package:rest_o/utils/background_service.dart';
import 'package:rest_o/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
        DetailsScreen.id: (context) => ChangeNotifierProvider<DetailsProvider>(
            create: (context) => DetailsProvider(apiHelper: ApiHelper()),
            child: DetailsScreen(
              restaurantId: ModalRoute.of(context).settings.arguments,
            )),
        FavoritesScreen.id: (context) =>
            ChangeNotifierProvider<FavoritesProvider>(
                create: (context) => FavoritesProvider(),
                child: FavoritesScreen()),
        SettingsScreen.id: (context) =>
            ChangeNotifierProvider<SettingsProvider>(
              create: (context) => SettingsProvider(),
              child: SettingsScreen(),
            ),
      },
    );
  }
}
