import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser curentUser = await _auth.currentUser();
    assert(user.uid == curentUser.uid);
    print('Signed In User: ${user.displayName}');
    return user;

    // FirebaseUser firebaseUser = await _auth.signInWithGoogle(
    //   idToken: googleSignInAuthentication.idToken,
    //   accessToken: googleSignInAuthentication.accessToken,
    // );
    // print("Username:  ${firebaseUser.displayName}");
    // return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              child: Text('Sign In'),
              onPressed: () {
                _signIn();
              },
            ),
            FlatButton(
              child: Text('Sign In'),
              onPressed: () {},
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
