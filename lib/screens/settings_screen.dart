import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Notifications"),
            subtitle: Text("Enable notifications"),
            value: isEnabled,
            onChanged: (val) {
              setState(() {
                isEnabled = !isEnabled;
              });
            },
          ),
        ],
      ),
    );
  }
}
