import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late MapController _controller;
  late DatabaseReference _databaseReference;
  double mspLatitude = 0.0;
  double mspLongitude = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = MapController.withPosition(
      initPosition: GeoPoint(latitude: mspLatitude, longitude: mspLongitude),
    );

    // Get reference to Firebase Realtime Database
    _databaseReference = FirebaseDatabase.instance.ref().child('msp430');

    // Listen for updates to latitude and longitude from Firebase
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map;
      setState(() {
        mspLatitude = data['latitude'];
        mspLongitude = data['longitude'];
      });

      // Update the map location with new coordinates
      _controller.changeLocation(GeoPoint(latitude: mspLatitude, longitude: mspLongitude));
    });
  }

  // Fetch MSP430 location (re-read Firebase data manually)
  void _fetchMSP430Location() {
    _databaseReference.once().then((DataSnapshot snapshot) {
      final data = snapshot.value as Map;
      setState(() {
        mspLatitude = data['latitude'];
        mspLongitude = data['longitude'];
      });

      // Update the map location manually
      _controller.changeLocation(GeoPoint(latitude: mspLatitude, longitude: mspLongitude));
    } as FutureOr Function(DatabaseEvent value));
  }

  // Go to user's current location
  Future<void> _goToUserLocation() async {
    await _controller.currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MSP430 Location Tracker"),
      ),
      body: Stack(
        children: [
          OSMFlutter(
            controller: _controller,
            osmOption: const OSMOption(
              userTrackingOption: UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: ZoomOption(
                initZoom: 8,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: _fetchMSP430Location, // Fetch MSP430 location manually
              child: const Icon(Icons.person_pin_circle),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: _goToUserLocation, // Center map to user's current location
              child: const Icon(Icons.circle),
            ),
          ),
        ],
      ),
    );
  }
}
