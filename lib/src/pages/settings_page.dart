
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SettingsPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> with AutomaticKeepAliveClientMixin<SettingsPage>{

  bool setting1 = true;
  bool setting2 = true;
  bool setting3 = true;
  bool setting4 = true;


  @override
  Widget build(BuildContext context) {
    super.build(context);
     return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(2),
        children: <Widget>[
          SwitchListTile(
            tileColor: Colors.red,
            title: const Text('Setting 1'),
            value: setting1,
            onChanged:(bool? value) {
              setState(() {
                setting1 = value!;
              });
             },
          ),
          SwitchListTile(
            tileColor: Colors.red,
            title: const Text('Setting 2'),
            value: setting2,
            onChanged:(bool? value) {
              setState(() {
                setting2 = value!;
              });
             },
          ),
          SwitchListTile(
            tileColor: Colors.red,
            title: const Text('Setting 3'),
            value: setting3,
            onChanged:(bool? value) {
              setState(() {
                setting3 = value!;
              });
             },
          ),
          SwitchListTile(
            tileColor: Colors.red,
            title: const Text('Setting 4'),
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