import 'package:CrimeMap/screens/auth.dart';
import 'package:CrimeMap/screens/maps.dart';
import 'package:CrimeMap/screens/newMap.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String username;
  SharedPref sharedPrefs;
  // void getUser() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   String user = sharedPreferences.getString('username');
  //   setState(() {
  //     username = user;
  //   });
  // }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    String name = await sharedPrefs.getUser();
    setState(() {
      username = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crime Map',
        theme: ThemeData(
          primaryColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: username == null ? Auth() : MapsRealTrial());
  }
}

class SharedPref {
  Future<String> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final key = 'username';
    final valueStored = preferences.getString(key);

    print('Retrieved User: $valueStored');

    return valueStored;
  }
}
