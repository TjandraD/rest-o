import 'dart:isolate';
import 'dart:ui';
import 'package:rest_o/data/api/api_helper.dart';
import 'package:rest_o/main.dart';

import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> randomRestaurantCallback() async {
    print('Alarm fired!');
    try {
      final NotificationHelper _notificationHelper = NotificationHelper();
      var result = await ApiHelper().getRestaurantList();
      if (result != null && result.restaurants.length > 0) {
        await _notificationHelper.showNotification(
          flutterLocalNotificationsPlugin,
          result,
        );
      }
    } catch (e) {
      print("error: $e");
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
