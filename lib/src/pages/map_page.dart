import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project/src/pages/home_page.dart';
import 'package:flutter/services.dart';
import '../utils/tile_servers.dart';
import '../utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'dart:async';
import 'dart:convert';



class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  MarkersPageState createState() => MarkersPageState();
}

class MarkersPageState extends State<MapPage> {

// Variable holders for the Geolocator coordinates (Used to determine map starting point)
  double currentLong = HomeState.long;
  double currentLat = HomeState.lat;

  final controller = MapController(
    location: LatLng(Angle.degree(HomeState.lat), Angle.degree(HomeState.long)),
  );

// List of marker locations waiting to be built
  List items = [];

// JSON parser
  Future<void> readJson() async{
    final String response = await rootBundle.loadString('assets/data/music.json');
    final data = await json.decode(response);
    setState(() {
      items = data["music"];
    });
  }

// Sets the map's starting origin to the user's location
  void _gotoDefault() {
    controller.center = LatLng(Angle.degree(HomeState.lat), Angle.degree(HomeState.long));
    setState(() {});
  }

// Double tap zoom incrementation
  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

// Updates scale of map on zoom
  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

// Builds markers from latlong objects
  Widget buildMarkerWidget(Offset pos, musicItem,
      [IconData icon = Icons.circle]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: GestureDetector(
        child: Icon(
          icon,
          color: const Color.fromARGB(150, 78, 232, 94),
          size: 72,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              content: Column(
                
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Container(color: Colors.lightGreenAccent, width: 200, height: 200)),
                  Text(musicItem["name"], style: const TextStyle(color: Colors.white, fontSize:18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  Text(musicItem["artist"], style: const TextStyle(color: Colors.grey, fontSize: 18, )),
                  Text(musicItem["album"], style: const TextStyle(color: Colors.grey))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          
          //MAP OBJECT
          body: MapLayout(
            controller: controller,
            builder: (context, transformer) {

              // Parses JSON
              readJson();
              //Builds markers from external JSON
              final markerWidgets = items.map(
                (musicItem) => buildMarkerWidget(transformer.toOffset(LatLng(Angle.degree(musicItem["lat"]), Angle.degree(musicItem["long"]))), musicItem),

              );


              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTapDown: (details) => _onDoubleTap(
                  transformer,
                  details.localPosition,
                ),
                onScaleStart: _onScaleStart,
                onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta.dy / -1000.0;
                      final zoom = clamp(controller.zoom + delta, 2, 18);

                      transformer.setZoomInPlace(zoom, event.localPosition);
                      setState(() {});
                    }
                  },
                  child: Stack(
                    children: [
                      TileLayer(
                        builder: (context, x, y, z) {
                          final tilesInZoom = pow(2.0, z).floor();

                          while (x < 0) {
                            x += tilesInZoom;
                          }
                          while (y < 0) {
                            y += tilesInZoom;
                          }

                          x %= tilesInZoom;
                          y %= tilesInZoom;

                          return CachedNetworkImage(
                            imageUrl: google(z, x, y),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      ...markerWidgets,
                    ],
                  ),
                ),
              );
            },
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: _gotoDefault,
          tooltip: 'My Location',
          child: const Icon(Icons.my_location),
        ),
      ),
      Container(alignment: Alignment.topCenter, child: const Text("Showing nearby listening history", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)) )
      ],
    );
  }
}
