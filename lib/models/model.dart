import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String name;
  String email;

  User({
    this.email,
    this.name,
  });
}

class CrimeLocation extends ChangeNotifier {
  double latitude;
  double longitude;
  int reportNumber;

  CrimeLocation({
    this.latitude,
    this.reportNumber,
    this.longitude,
  });
  int reportNumbers = 0;
  void incrementCrime() {
    reportNumbers++;
    print(reportNumbers);
    notifyListeners();
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
