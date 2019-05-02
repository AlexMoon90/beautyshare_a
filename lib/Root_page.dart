import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'User.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'Mainpage.dart';


class rootPage extends StatelessWidget {
  final DocumentSnapshot Doc;
  rootPage(this.Doc);
  User currenuser;


  @override

  Widget build(BuildContext context)   {

    currenuser = User.fromsnapshot(Doc);;



    return UserProvider(
      bloc: currenuser,
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white,
            backgroundColor: Colors.white
        ),
      debugShowCheckedModeBanner: false,
      home : Mainpage(), )
    )
    ;
  }
}
