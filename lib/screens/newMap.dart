import 'dart:typed_data';

import 'package:CrimeMap/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

class MapsRealTrial extends StatefulWidget {
  @override
  _MapsRealTrialState createState() => _MapsRealTrialState();
}

class _MapsRealTrialState extends State<MapsRealTrial> {
  List<Marker> _markers = [];
  GoogleMapController _controller;

  List<CrimeLocation> _crimeLocations = CrimeLocation.getCrimes;

  // Uint8List redMarkerIcon;
  // Uint8List greenMarkerIcon;
  // Uint8List orangeMarkerIcon;
  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
  //       .buffer
  //       .asUint8List();
  // }

  // setMarkers() async {
  //   redMarkerIcon = await getBytesFromAsset('assets/red_marker.jpg', 100);
  //   greenMarkerIcon = await getBytesFromAsset('assets/green_marker.png', 100);
  //   orangeMarkerIcon = await getBytesFromAsset('assets/orange_marker.png', 100);
  // }

  BitmapDescriptor myRedIcon;

  BitmapDescriptor myOrangeIcon;

  BitmapDescriptor myGreenIcon;

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/red_marker.jpg')
        .then((onValue) {
      myRedIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/green_marker.png')
        .then((onValue) {
      myGreenIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/orange_marker.png')
        .then((onValue) {
      myOrangeIcon = onValue;
    });
    //Add Markers
    _crimeLocations.forEach((element) {
      if (element.reportNumber < 5) {
        _markers.add(
          Marker(
            icon: myGreenIcon,
            markerId: MarkerId(element.id.toString()),
            draggable: false,
            infoWindow: InfoWindow(
              title: element.location,
              snippet: element.reportNumber.toString(),
            ),
            onTap: () {
              moveMarker(element.latitude, element.longitude);
              print('Marker tapped');
            },
            position: LatLng(element.latitude, element.longitude),
          ),
        );
      } else if (element.reportNumber > 5 && element.reportNumber < 20) {
        _markers.add(
          Marker(
            icon: myOrangeIcon,
            markerId: MarkerId(element.id.toString()),
            draggable: false,
            infoWindow: InfoWindow(
              title: element.location,
              snippet: element.reportNumber.toString(),
            ),
            onTap: () {
              moveMarker(element.latitude, element.longitude);
              print('Marker tapped');
            },
            position: LatLng(element.latitude, element.longitude),
          ),
        );
      } else if (element.reportNumber > 20) {
        _markers.add(
          Marker(
            icon: myRedIcon,
            markerId: MarkerId(element.id.toString()),
            draggable: false,
            infoWindow: InfoWindow(
              title: element.location,
              snippet: element.reportNumber.toString(),
            ),
            onTap: () {
              moveMarker(element.latitude, element.longitude);
              print('Marker tapped');
            },
            position: LatLng(element.latitude, element.longitude),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crime Maps',
          style: TextStyle(
            color: Colors.white,
            fontSize: width / 100 * 8,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          _map(),
          _fab(context, height, width),
        ],
      ),
    );
  }

  Widget _popupAdd(BuildContext context, height, width) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              height: height * .06,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Type Location to add Crime Area'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _map() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(1.2921, 36.8219),
          zoom: 5.0,
        ),
        markers: Set.from(_markers),
        onMapCreated: mapCreated,
      ),
    );
  }

  Widget _fab(BuildContext context, height, width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: InkWell(
          onTap: () {
            _popupAdd(context, height, width);
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _trials() {
    Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () => moveToNairobi(),
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.green,
          ),
          child: Icon(
            Icons.forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _trial2() {
    Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () => moveToNewYork(),
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.red,
          ),
          child: Icon(
            Icons.backspace,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveToNairobi() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(1.2921, 36.8219),
        zoom: 12.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }

  moveToNewYork() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(40.712, -74.0060),
        zoom: 12.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }

  moveMarker(latitude, longitude) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 12.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }
}
