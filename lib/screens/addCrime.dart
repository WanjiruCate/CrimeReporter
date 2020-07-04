import 'package:CrimeMap/models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCrime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CrimeLocation>(
      create: (context) => CrimeLocation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crime Map'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Consumer<CrimeLocation>(builder: (context, crimeLocation, child) {
              return Text(
                crimeLocation.reportNumber.toString(),
              );
            }),
            Consumer<CrimeLocation>(
              builder: (context, crimeLocation, child) {
                return RaisedButton(
                  onPressed: () {
                    crimeLocation.incrementCrime();
                  },
                  child: Text('Press'),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
