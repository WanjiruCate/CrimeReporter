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

  void incrementCrime() {
    reportNumber++;
    notifyListeners();
  }
}
