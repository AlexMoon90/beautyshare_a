import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'User.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'Mainpage.dart';
import 'Root_page.dart';


user_transform ( String b, BuildContext context) async {

  if (b != null) {
    var dbuser = Firestore.instance.collection('User').document(b);

   FirebaseAuth.instance.currentUser().then((a) async { Firestore.instance.collection('User').document(b).snapshots().listen((datasnapshot)  {


      if (datasnapshot.exists) {
      } else if (!datasnapshot.exists) {
        dbuser.setData( {'displayName': a.displayName,
          'email': a.email,
          'photoUrl': a.photoUrl } );
      } } ) ; } );

  }
  else {

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('잘못된정보 입니다. 이메일 또는 비밀번호를 확인해주세요'),
      ),
    );
  }
}