import 'package:cloud_firestore/cloud_firestore.dart';

class Favor_review {
  final String displayName;
  final String email;
  final String photoUrl;
  final List favorreview;
  final List favorshop;
  final DocumentReference reference;


  Favor_review.fromMap(Map <String, dynamic > map, {this.reference}) :
        displayName = map["displayName"],
        email = map["email"],
        photoUrl = map["photoUrl"],
        favorreview = map["favorreview"],
        favorshop = map["favorshop"];


  Favor_review.fromsnapshot (DocumentSnapshot snapshot)
      : this.fromMap (snapshot.data, reference :snapshot.reference) ;
}
