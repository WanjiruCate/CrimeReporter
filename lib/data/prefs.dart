import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  ///Set the crimeRates
  Future<void> setCrimeRates(int crimeNumber) async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'crimeNumber';
    final valueStored = crimeNumber;

    preferences.setInt(key, valueStored);
  }

//Get CrimeRates
  Future<int> getCrimeRates() async {
    final prefernces = await SharedPreferences.getInstance();
    final key = 'crimeNumber';
    final valueStored = prefernces.getInt(key);

    return valueStored;
  }
}
