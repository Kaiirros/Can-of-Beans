
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'dart:developer' as developer;

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  HomePage(this.themeStream);
  final Stream themeStream;  

  @override
  // ignore: library_private_types_in_public_api
  HomeState createState() => HomeState();
  
}
class HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  static double long = 0;
  static double lat = 0;
  bool darkTheme = false;
 
  @override
  void initState(){
    super.initState();
    setCoords();
    widget.themeStream.listen((theme) {
      setTheme(theme);
    });
  }

void setTheme(bool theme){
  setState(() {
    developer.log("setTheme Homepage");
    darkTheme = theme;
  });
}


  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: darkTheme? const Color.fromARGB(255, 36, 36, 36) : const Color.fromARGB(255, 188, 188, 188),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            darkTheme? const Text("Currently listening to...", style: TextStyle( color: Colors.white, fontSize: 20)) : const Text("Currently listening to...", style: TextStyle( color: Colors.black, fontSize: 20)) ,
            Padding( padding: const EdgeInsets.only(top: 20, bottom: 20), child: Container(width: 200, height: 200, color: Colors.lightGreenAccent)),
            darkTheme? const Text("Island In The Sun", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)) : const Text("Island In The Sun", style: TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
            darkTheme? const Text("Weezer", style: TextStyle( color: Colors.grey, fontSize: 19, )) : const Text("Weezer", style: TextStyle( color: Color.fromARGB(255, 102, 102, 102), fontSize: 19, )),
            darkTheme? const Text("Weezer", style: TextStyle( color: Colors.grey, fontSize: 17, )) : const Text("Weezer", style: TextStyle( color: Color.fromARGB(255, 102, 102, 102), fontSize: 17, )),
            const Spacer(),
            Column(
                children: <Widget>[
                  darkTheme? const Text("Your current location", style: TextStyle( color: Colors.white, fontSize: 20)) : const Text("Your current location", style: TextStyle( color: Colors.black, fontSize: 20)) ,
                  darkTheme? Text("$lat, $long", style: const TextStyle( color: Colors.white, fontSize: 20)) : Text("$lat, $long", style: const TextStyle( color: Colors.black, fontSize: 20)),
              ],
            ),
        ], 
        ),
        ),
        ),
      );
  }
  
  @override
  bool get wantKeepAlive => true;

  void setCoords() async{
    Position pos = await _determinePosition();
    setState(() {
      long = pos.longitude;
      lat = pos.latitude;
    });

  }
}


// takes position from geolocator, returns it to var in main
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}



