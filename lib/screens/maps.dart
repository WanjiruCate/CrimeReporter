// import 'package:CrimeMap/models/model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class Maps extends StatefulWidget {
//   final CrimeLocation crimeLocation;
//   Maps({
//     Key key,
//     this.crimeLocation,
//   });
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   CrimeLocation crimeLocation;

//   List<Marker> allMarkers = [];

//   int prevPage;
//   PageController _pageController;
//   GoogleMapController _controller;
//   Position _currentPosition;
//   @override
//   void initState() {
//     crimeLocation = widget.crimeLocation;
//     _getCurrentLocation();
//     _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
//       ..addListener(_onScroll);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //Add Markers
//     crimeLocation.crimes.forEach((element) {
//       allMarkers.add(
//         Marker(
//             markerId: MarkerId(element.id.toString()),
//             position: element.locationCoords,
//             infoWindow:
//                 InfoWindow(title: element.venue, snippet: element.location)),
//       );
//     });
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         body: _currentPosition == null
//             ? CircularProgressIndicator()
//             : Stack(
//                 children: <Widget>[
//                   _map(width),
//                   _title("Crime Map", width, height),
//                   _addCrimeArea(height, width),
//                 ],
//               ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             _popupAdd(context, height, width);
//           },
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//           backgroundColor: Colors.green,
//         ),
//       ),
//     );
//   }

//   Widget _map(width) {
//     return Container(
//       width: width,
//       child: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//           zoom: 10.5,
//         ),
//         markers: Set.from(allMarkers),
//         // circles: circles,
//         onMapCreated: mapCreated,
//       ),
//     );
//   }

//   Widget _title(text, width, height) {
//     return Positioned(
//       top: 0,
//       child: Container(
//         color: Colors.green,
//         width: width,
//         // height: height * .1,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             text,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: width / 100 * 10,
//               fontWeight: FontWeight.w500,
//               fontStyle: FontStyle.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _popupAdd(BuildContext context, height, width) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Container(
//               height: height * .06,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text('Try here'),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Widget _addCrimeArea(height, width) {
//     return Positioned(
//       top: height * .1,
//       left: width * .09,
//       right: width * .09,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         height: height * .04,
//         width: width * .9,
//         child: Text(
//           'Add Here',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: width / 100 * 5,
//             fontWeight: FontWeight.w500,
//             fontStyle: FontStyle.normal,
//           ),
//         ),
//       ),
//     );
//   }

//   void mapCreated(controller) {
//     setState(() {
//       _controller = controller;
//     });
//   }

//   void _onScroll() {
//     if (_pageController.page.toInt() != prevPage) {
//       prevPage = _pageController.page.toInt();
//       //   moveCamera();
//     }
//   }

//   moveCamera() {
//     _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target:
//             crimeLocation.crimes[_pageController.page.toInt()].locationCoords,
//         zoom: 14.0,
//         bearing: 45.0,
//         tilt: 45.0)));
//   }

//   _getCurrentLocation() {
//     final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

//     geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
// }
