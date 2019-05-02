import 'package:cloud_firestore/cloud_firestore.dart';

class Record_loca {
  final String shoptitle;
  final List photoUrl;
  final List shop_class;
  final String shopintro;
  final int favor_shop;
  final String shop_address;
  final String shop_phone;
  final Timestamp timestamp;
  final DocumentReference reference;
  final List favorid;
  final Map  product_class;

  Record_loca.fromMap(Map<String, dynamic> map, {this.reference}) :
        shoptitle = map["shoptitle"],
        photoUrl = map["photoUrl"],
        shop_class = map["shop_class"],
        shopintro = map["shopintro"],
        favor_shop = map["favor_shop"],
        shop_address = map["shop_address"],
        shop_phone = map["shop_phone"],
        timestamp = map["timestamp"],
        favorid = map["favorid"],
        product_class = map["product_class"] ;


  Record_loca.fromsnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
