import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:rest_o/data/preferences/preferences_helper.dart';
import 'package:rest_o/utils/background_service.dart';
import 'package:rest_o/utils/datetime_helper.dart';

class SettingsProvider extends ChangeNotifier {
  SharedPreferencesHelper _preferencesHelper = SharedPreferencesHelper();

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive =
        await _preferencesHelper.getTimer(DAILY_NOTIFICATION) ?? false;
    notifyListeners();
  }

  void toogleDailyNotification(bool value) {
    _preferencesHelper.setTimer(DAILY_NOTIFICATION, value);
    _getDailyNotificationPreferences();
    _scheduledNotification(value);
  }

  Future<bool> _scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduled notification activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.randomRestaurantCallback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Notification Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
