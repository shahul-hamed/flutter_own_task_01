import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class LiveLocationCapture extends StatefulWidget {
  @override
  _LiveLocationCaptureState createState() => _LiveLocationCaptureState();
}

class _LiveLocationCaptureState extends State<LiveLocationCapture> {
  String _locationMessage = "Fetching location...";
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  // Request location permissions and start listening for location updates
  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      _startLocationUpdates();
    } else {
      setState(() {
        _locationMessage = "Location permission denied!";
      });
    }
  }

  // Start listening for location updates
  void _startLocationUpdates() {
    // Listen for location updates every 5 seconds
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high, // Can be adjusted based on accuracy needs
        distanceFilter: 10, // Update location if the device moves by 10 meters
      ),
    ).listen((Position position) async {
      String location = await _getAddressFromLatLng(position);
      setState(()  {
        // _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        _locationMessage = location;
      });
    });
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    String currentAddress ="";
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
        currentAddress =
        '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
    return currentAddress;
  }


  @override
  void dispose() {
    // Cancel the location stream subscription when the widget is disposed
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Real-Time Location')),
      body: Center(
        child: Text(
          _locationMessage,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
