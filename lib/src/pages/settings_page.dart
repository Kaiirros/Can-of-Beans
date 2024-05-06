import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:developer' as developer;


// ignore: use_key_in_widget_constructors
class SettingsPage extends StatefulWidget {
    const SettingsPage(this.toDarkMode, {super.key});
    // Constructor to take nav bar void callback to set its own darkMode variable to true/false and set it's state
    final VoidCallback toDarkMode;
  
  @override
  // ignore: library_private_types_in_public_api
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> with AutomaticKeepAliveClientMixin<SettingsPage>{
  // Dark mode toggle boolean
  static bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
     return Scaffold(
      backgroundColor: (darkMode ? const Color.fromARGB(255, 36, 36, 36) : const Color.fromARGB(255, 188, 188, 188)),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            tileColor: (darkMode ? Colors.black : Colors.white),
            title: (darkMode ? const Text('Dark Mode', style: TextStyle(color: Colors.white)) : const Text('Dark Mode', style: TextStyle(color: Colors.black))),
            value: darkMode,
            onChanged:(bool value) {
              //Dark mode set state toggle
              setState(() {
                developer.log("entered state");
                  widget.toDarkMode();
                  darkMode = !darkMode;
              });
             },
          ),
          // Elevated button which takes you to the app's permissions (Does not work on Chrome)
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: (darkMode ? Colors.black : Colors.white)),
            child: (darkMode ? const Text('View App Permissions', style: TextStyle(color: Colors.white)) : const Text('View App Permissions', style: TextStyle(color: Colors.black))),
            onPressed:() {
              // Permission Handler component function
              openAppSettings();             
             },
          ),
        ],
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}