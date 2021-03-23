import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_o/provider/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings_screen';

  void toggleNotification(bool value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Consumer<SettingsProvider>(
            builder: (context, state, _) {
              return SwitchListTile(
                title: Text("Notifications"),
                subtitle: Text("Enable notifications"),
                value: state.isDailyNotificationActive,
                onChanged: (newValue) {
                  if (Platform.isAndroid) {
                    state.toogleDailyNotification(newValue);
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('We are working on this feature!'),
                          content: Text(
                              'This feature is only available for Android!'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
