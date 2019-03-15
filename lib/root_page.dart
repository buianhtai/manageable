import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manageable/home_page.dart';
import 'package:manageable/login_screen.dart';
import 'package:manageable/splash_page.dart';
import 'package:manageable/globals.dart' as globals;

final FirebaseAuth _auth = FirebaseAuth.instance;

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return SplashPage();
        }

        if(snapshot.hasData) {
          globals.uid = snapshot.data.uid;
          globals.email = snapshot.data.email;

          print('logged in with user ' + globals.email);

          return HomePage(title: snapshot.data.uid);
        }

        return LoginPage();
      },
    );
  }
}
