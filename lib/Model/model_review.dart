import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String userid;
  final String displayName;
  final String shoptitle;
  final String stylistname;
  final String stylistpositoin;
  final List photoUrl;
  final String serv_class;
  final String reviewtext;
  final int favor_review;
  final GeoPoint shop_loca;
  final DateTime timestamp;
  final DocumentReference reference;
  final List favorid;
  final double distance;

  Record.fromMap(Map <String, dynamic > map, {this.reference}) :
        userid = map["userid"],
        displayName= map["displayName"],
        shoptitle = map["shoptitle"] ,
        stylistname= map["stylistname"] ,
        stylistpositoin=map["stylistposition"],
        photoUrl= map["photoUrl"] ,
        serv_class =map[ "serv_class"] ,
        reviewtext=map[ "reviewtext"] ,
        favor_review = map [ "favor_review"] ,
        shop_loca = map["shop_loca" ],
        timestamp  = map[ "timestamp"],
        favorid = map ["favorid"],
        distance = map["distance"];



  Record.fromsnapshot (DocumentSnapshot snapshot)
      : this.fromMap (snapshot.data, reference : snapshot.reference);
}