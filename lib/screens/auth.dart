import 'package:CrimeMap/models/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'maps.dart';

class Auth extends StatelessWidget {
  CrimeLocation crimeLocation;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> _signIn() async {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser curentUser = await _auth.currentUser();
      assert(user.uid == curentUser.uid);

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.setString('user', user.displayName);

      if (curentUser != null) {
        Fluttertoast.showToast(
          msg: 'SignIn Successful',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                Maps(crimeLocation: crimeLocation)));
        print('Signed In User: ${user.displayName}');
      } else {
        Fluttertoast.showToast(
          msg: 'SignIn Failed',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      return user;

      // FirebaseUser firebaseUser = await _auth.signInWithGoogle(
      //   idToken: googleSignInAuthentication.idToken,
      //   accessToken: googleSignInAuthentication.accessToken,
      // );
      // print("Username:  ${firebaseUser.displayName}");
      // return firebaseUser;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              //  color: Colors.white,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/google_logo.png'),
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                _signIn();
              },
            ),
            Text('Tap to Sign In'),
          ],
        ),
      ),
    );
  }
}
