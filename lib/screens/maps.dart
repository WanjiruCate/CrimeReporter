import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  List<Marker> allMarkers = [];
  int prevPage;
  PageController _pageController;
  GoogleMapController _controller;
  Position _currentPosition;
  @override
  void initState() {
    _getCurrentLocation();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(35.89, 9.0),
                zoom: 10.5,
              ),
              markers: Set.from(allMarkers),
              // circles: circles,
              onMapCreated: mapCreated,
            ),
          ),
        ],
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      //   moveCamera();
    }
  }

  // moveCamera() {
  //   _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: upcomingEvents[_pageController.page.toInt()].locationCoords,
  //       zoom: 14.0,
  //       bearing: 45.0,
  //       tilt: 45.0)));
  // }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
