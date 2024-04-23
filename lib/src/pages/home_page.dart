
import 'package:flutter/material.dart';


// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
          child: Text("Home Page"),
        ),
      );
  }
  
  @override
  bool get wantKeepAlive => true;
}