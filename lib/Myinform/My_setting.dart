import 'package:flutter/material.dart';
import 'package:beautyshare_a/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class my_setting extends StatelessWidget {

  var auth = Auth();

  @override
  Widget build(BuildContext context) {

    return

      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.1,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: ()=>Navigator.pop(context)),
          title: Text('설정하기'),


        ),

        body: Column(
          children: <Widget>[

            GestureDetector(
              onTap: () {

                StreamBuilder<FirebaseUser>(
                    stream: FirebaseAuth.instance.onAuthStateChanged,
                    builder: (BuildContext context, snapshot) {

                   return Text(snapshot.data.email);

                    }
                );

                           auth.signOut();

                           },
              child: Container(
                width: 150.0,
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(50.0)),
                child: Text(" 로그아웃 "),
              ),
            )
          ],
        ),

      );
  }

}