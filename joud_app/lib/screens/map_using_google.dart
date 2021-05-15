import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

// test#2
class _MapPage extends State<MapPage> {
  double _lat =31.963158;
  double _lng =35.930359 ;//13.0827 80.2707;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  CameraPosition _currentPosition;

  @override
  initState() {
    super.initState();
    _currentPosition = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 15,
    );
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude;
        _lng = res.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _currentPosition,
          markers: {
            Marker(
              markerId: MarkerId('current'),
              position: LatLng(_lat, _lng),
            )
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () => _locateMe(),
      ),
    );
  }
}

// test #1
//  class _MapPage extends State<MapPage> {
//   Completer<GoogleMapController> _completer = Completer();
//   CameraPosition _cameraPosition =
//       CameraPosition(target: LatLng(13.0827, 80.2707), zoom: 15);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Google Map"),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: GoogleMap(
//           initialCameraPosition: _cameraPosition,
//           onMapCreated: (GoogleMapController cont) {
//             _completer.complete();
//           },
//         ),
//       ),
//     );
//   }
// }
