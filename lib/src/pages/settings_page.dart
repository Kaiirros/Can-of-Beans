
import 'package:final_project/src/components/bottom_navbar.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as developer;


// ignore: use_key_in_widget_constructors
class SettingsPage extends StatefulWidget {
    const SettingsPage(this.toDarkMode);
    final VoidCallback toDarkMode;
  
  @override
  // ignore: library_private_types_in_public_api
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> with AutomaticKeepAliveClientMixin<SettingsPage>{

  static bool darkMode = false;
  bool setting2 = true;
  bool setting3 = true;
  bool setting4 = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
     return Scaffold(
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            tileColor: (darkMode ? Colors.black : Colors.white),
            title: (darkMode ? const Text('Dark Mode', style: TextStyle(color: Colors.white)) : const Text('Setting 2', style: TextStyle(color: Colors.black))),
            value: darkMode,
            onChanged:(bool value) {
              setState(() {
                developer.log("entered state");
                  widget.toDarkMode();
                  darkMode = !darkMode;
              });
             },
          ),
          SwitchListTile(
            tileColor: (darkMode ? Colors.black : Colors.white),
            title: (darkMode ? const Text('Setting 2', style: TextStyle(color: Colors.white)) : const Text('Setting 2', style: TextStyle(color: Colors.black))),
            value: setting2,
            onChanged:(bool? value) {
              setState(() {
                setting2 = value!;
              });
             },
          ),
          SwitchListTile(
            tileColor: (darkMode ? Colors.black : Colors.white),
            title: (darkMode ? const Text('Setting 2', style: TextStyle(color: Colors.white)) : const Text('Setting 2', style: TextStyle(color: Colors.black))),
            value: setting3,
            onChanged:(bool? value) {
              setState(() {
                setting3 = value!;
              });
             },
          ),
          SwitchListTile(
            tileColor: (darkMode ? Colors.black : Colors.white),
            title: (darkMode ? const Text('Setting 2', style: TextStyle(color: Colors.white)) : const Text('Setting 2', style: TextStyle(color: Colors.black))),
            value: setting4,
            onChanged:(bool? value) {
              setState(() {
                setting4 = value!;
              });
             },
          ),

        ],
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}