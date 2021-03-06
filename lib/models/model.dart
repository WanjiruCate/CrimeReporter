import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User extends ChangeNotifier {
  String name;
  String email;

  User({
    this.email,
    this.name,
  });
  static List<User> getUsers = [
    User(
      name: 'Wanjiru',
      email: "catherinemunene802@gmail.com",
    ),
    User(
      name: 'Wanjiru',
      email: "catherinemunene802@gmail.com",
    ),
    User(
      name: 'Wanjiru',
      email: "catherinemunene802@gmail.com",
    ),
  ];
}

class CrimeLocation extends ChangeNotifier {
  int id;
  double latitude;
  double longitude;
  int reportNumber;
  String location;
  String venue;
  CrimeLocation({
    this.id,
    this.latitude,
    this.reportNumber,
    this.longitude,
    this.location,
    this.venue,
  });
  static List<CrimeLocation> getCrimes = [
    CrimeLocation(
      id: 1,
      latitude: 23.90,
      longitude: 2.56,
      reportNumber: 8,
      location: 'Abuja',
      venue: 'Kiserian',
    ),
    CrimeLocation(
      id: 2,
      latitude: 1.2921,
      longitude: 36.8219,
      reportNumber: 8,
      location: 'Kenya',
      venue: 'Kiserian',
    ),
    CrimeLocation(
      id: 3,
      latitude: 1.9441,
      longitude: 30.0619,
      reportNumber: 8,
      location: 'Kigali',
      venue: 'Kiserian',
    ),
     CrimeLocation(
      id: 4,
      latitude: 23.90,
      longitude: 0.56,
      reportNumber: 8,
      location: 'Abuja',
      venue: 'Kiserian',
    ),
     CrimeLocation(
      id: 5,
      latitude: 23.90,
      longitude: 2.56,
      reportNumber: 8,
      location: 'Abuja',
      venue: 'Kiserian',
    ),
     CrimeLocation(
      id: 6,
      latitude: 13.90,
      longitude: 2.56,
      reportNumber: 8,
      location: 'Abuja',
      venue: 'Kiserian',
    ),
  ];

  get locationCoords => LatLng(latitude, longitude);

  ///TODO Refractor this
  int reportNumbers = 0;
  void incrementCrime() {
    reportNumbers++;
    print(reportNumbers);
    //   notifyListeners();
  }
}

class Providers extends ChangeNotifier {
  CrimeLocation crimeLocation = new CrimeLocation();

  void incrementCrime() {
    crimeLocation.reportNumbers++;
    print(crimeLocation.reportNumbers);
    notifyListeners();
  }
}
