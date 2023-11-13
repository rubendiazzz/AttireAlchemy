import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
          ),
          ListTile(
            title: Text("Privacy"),
            leading: Icon(Icons.lock),
          ),
          ListTile(
            title: Text("Help & Support"),
            leading: Icon(Icons.help),
          ),
          ListTile(
            title: Text("About"),
            leading: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
