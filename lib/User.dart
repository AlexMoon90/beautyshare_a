import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

  class User {
  final String displayName;
  final String email;
  final String photoUrl;
  final DocumentReference reference;


  User.fromMap(Map <String, dynamic > map, {this.reference}) :
  displayName = map["displayName"],
  email = map["email"] ,
  photoUrl= map["photoUrl"] ;


  User.fromsnapshot (DocumentSnapshot snapshot)
      : this.fromMap (snapshot.data, reference : snapshot.reference);
  }

