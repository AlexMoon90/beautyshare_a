import 'package:cloud_firestore/cloud_firestore.dart';

class Record_stylist {
  final String name;
  final String position;
  final String intro;
  final String photo;
  final DocumentReference reference;


  Record_stylist.fromMap(Map <String, dynamic > map, {this.reference}) :
        name = map["name"],
        position = map["position"] ,
        intro= map["intro"] ,
        photo= map["photo"] ;

  Record_stylist.fromsnapshot (DocumentSnapshot snapshot)
      : this.fromMap (snapshot.data, reference : snapshot.reference);
}