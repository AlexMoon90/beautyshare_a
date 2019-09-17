import 'package:flutter/material.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Root_page.dart';
import 'WaitngScreen.dart';
import 'Mainpage.dart';
import 'LoginPage.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';

void main() {
 // await Firestore.instance.settings(timestampsInSnapshotsEnabled: true);

  runApp(home());
}

class home extends StatelessWidget {
      @override
      Widget build(BuildContext context) {

      return
      AlertProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          home :
        StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingScreen();
              } else {
                if (snapshot.hasData) {
                  return StreamBuilder(
                      stream: FirebaseAuth.instance.currentUser().asStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return waitingScreen();

                        if (snapshot.hasData) {
                          FirebaseUser cuser = snapshot.data;
                          var useremail = cuser.email;
                          print("user : $useremail");

                          return StreamBuilder(
                              stream: Firestore.instance
                                  .collection('User')
                                  .document(useremail)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData || snapshot.connectionState==ConnectionState.none )

                                  return waitingScreen();

                                else if (snapshot.hasData&& snapshot.data.data==null) {
                                  return waitingScreen();}

                                  else {

                                   return rootPage(snapshot.data);
                                }
                              });
                        }
                      });
                }
                return LoginPage(Auth());
              }
            })),
      );
} }
