
import 'package:flutter/material.dart';


// ignore: use_key_in_widget_constructors
class MapPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> with AutomaticKeepAliveClientMixin<MapPage>{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 38, 38),
      body: Center(
          child: Text("Map Page"),
        ),
      );
  }
  
  @override
  bool get wantKeepAlive => true;
}