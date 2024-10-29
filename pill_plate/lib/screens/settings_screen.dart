import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Notifications'),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.blue),
            title: Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (val) {}),
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.blue),
            title: Text('Privacy Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
