import 'package:cloud_firestore/cloud_firestore.dart';

class Record_pr {
  final String shoptitle;
  final String shopphoto;
  final List shop_class;
  final String shopid;
  final DateTime startday;
  final DateTime endday;
  final String prtitle;
  final String prwho;
  final String prcontent;
  final String pretc;
  final DocumentReference reference;


  Record_pr.fromMap(Map<String, dynamic> map, {this.reference}) :
        shoptitle = map["shoptitle"],
        shopphoto = map["shopphoto"],
        shop_class = map["shop_class"],
        shopid = map["shopid"],
        startday = map["startday"],
        endday = map["endday"],
       prtitle = map["prtitle"],
        prwho = map["prwho"],
        prcontent = map["prcontent"],
        pretc = map["pretc"] ;


  Record_pr.fromsnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
