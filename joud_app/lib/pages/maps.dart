import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController googleMapControlar;
  var mmarkers = HashSet<Marker>(); // collection
  Position positi;
  List<Polyline> mypolyline = [];
  String addr1 = "";
  String addr2 = "";
  Position currentPosition;
  var geoLocator = Geolocator();
  void locatePosition() async {
    positi = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = positi;

    LatLng latlngpossiton = LatLng(positi.latitude, positi.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlngpossiton, zoom: 14);
    googleMapControlar
        .animateCamera(CameraUpdate.newCameraPosition((cameraPosition)));

    // setState(() {
    //   mmarkers.add(
    //     Marker(
    //         markerId: MarkerId('1'),
    //         position: LatLng(positi.latitude, positi.longitude)),
    //   );
    // });
  }

  createPolyLine() {
    mypolyline.add(
      Polyline(
          polylineId: PolylineId('1'),
          color: Colors.blue[900],
          width: 3,
          points: [LatLng(31.963158, 35.930359), LatLng(31.999000, 35.149900)]),
    );
  }

  @override
  void initState() {
    super.initState();
    //getAdressesBeaseOndLoc();
    createPolyLine();
  }

  getAdressesBeaseOndLoc() async {
    final coordinates = new Coordinates(31.963158, 35.930359);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      addr1 = address.first.featureName;
      addr2 = address.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
          //shadowColor: Colors.green,
          backgroundColor:Color.fromRGBO(230, 238, 156, 1.0),
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(31.963158, 35.930359), zoom: 11),
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controlar) {
                googleMapControlar = controlar;
                //locatePosition();
                setState(() {
                  mmarkers.add(
                    Marker(
                      markerId: MarkerId('1'),
                      position: LatLng(31.963158, 35.930359),
                      // icon: customMarker,
                    ),
                  );

                  googleMapControlar = controlar;
                  locatePosition();
                });
              },
              markers: mmarkers,
            ),
            // if we would like to add pic for example the app logo or pic
            // Container(child: Image.asset(name),)
            Container(
              child: Text('welcome To JOUD'),
              alignment: Alignment.bottomCenter,
            )
          ],
        ));
  }
}
