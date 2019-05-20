import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(GoogleMapMarker());

class GoogleMapMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleMapController mapController;

  MapType _currentMapType = MapType.normal;
  int _countMapType = 0;

  final LatLng _center = const LatLng(
      18.565217710414974, 73.81910808384418); //LatLng(45.521563, -122.677433);

  LatLng _lastMapPosition;

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _lastMapPosition = _center;
  }

  void _onCameraMove(CameraPosition position) {
    print('_onCameraMove --> ' +
        position.target.latitude.toString() +
        ' - ' +
        position.target.longitude.toString());
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            onTap: _handleTap,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  tooltip: 'Map Type',
                  child: Icon(Icons.map),
                )),
          ),
        ]),
      ),
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
//      _currentMapType = _currentMapType == MapType.normal
//          ? MapType.satellite
//          : MapType.normal;
      _countMapType = _countMapType + 1;
      if (_countMapType == 5) {
        _countMapType = 1;
      }
      if (_countMapType == 1) {
        _currentMapType = MapType.normal;
      } else if (_countMapType == 2) {
        _currentMapType = MapType.satellite;
      } else if (_countMapType == 3) {
        _currentMapType = MapType.hybrid;
      } else if (_countMapType == 4) {
        _currentMapType = MapType.terrain;
      }
      print('_onMapTypeButtonPressed --> ' +
          _countMapType.toString() +
          ' ' +
          _currentMapType.toString());
    });
  }

  void _handleTap(LatLng point) {
    print('_onAddMarkerButtonPressed');
    setState(() {
      _lastMapPosition = point;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Marker place',
          snippet: _lastMapPosition.latitude.toString() +
              ' - ' +
              _lastMapPosition.longitude.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
