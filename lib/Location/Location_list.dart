import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'package:transparent_image/transparent_image.dart';
import 'Location_infor.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';

class location_list extends StatelessWidget {
  final Stream<QuerySnapshot> doc;
  location_list(this.doc);


  Widget build(BuildContext context) {
    //Widget usage_list (BuildContext context1) {



    return StreamBuilder(
        stream: doc,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator()));

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            primary: true,
            padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 8.0, bottom: 0.0),
            itemBuilder: (context, index) =>
                locationTile(snapshot.data.documents[index], context),
          );
        });
  }
}

class locationTile extends StatelessWidget {
  final DocumentSnapshot data;
  final BuildContext context1;

  locationTile(this.data, this.context1);

  DocumentReference revewid ;

  @override
  Widget build(BuildContext context) {

    var cuser = UserProvider.of(context).bloc;
    revewid  = cuser.reference;

    var record = Record_loca.fromsnapshot(data);
    var record_stylist = data.reference.collection("Stylist").snapshots();
// 좋아아 하트모양과 숫자 증감 기능
    bool favorcolor;
   if ((record.favorid == null)  ) {
      favorcolor = false;
    } else if (record.favorid.contains(revewid)) {
     favorcolor = true;
   } else if (record.favorid.contains(revewid) == false) {
     favorcolor = false ;
   }


    return GestureDetector(
        onTap: () {
           Navigator.push(context1, MaterialPageRoute(
             builder: (cotext) => locationinfor(record, cuser, 1 )));
        },
        child: Card(

          margin: EdgeInsets.all(1.0),
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Row(
              children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left : 15.0),
              child: Container(
                constraints: BoxConstraints.tight( Size.square(120.0)),

                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'Loading_icon.gif',
                    image: record.photoUrl[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

           Expanded(
             child: Container(
               child: Padding(
                 padding: const EdgeInsets.only (left : 10.0, right : 10.0, top : 10.0, bottom: 10.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(record.shoptitle, style: TextStyle(fontSize: 22.0), ),
                     shopclass_show(record),
                     Text(record.shopintro, style: TextStyle(fontSize: 12.0, color: Colors.black45), overflow: TextOverflow.ellipsis, maxLines: 2,),

                     Row(

                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left : 0.0, top: 8.0, bottom: 8.0),
                           child: Container(
                               width: 100.0,
                               child: Text(record.shop_address, maxLines: 1, overflow: TextOverflow.ellipsis,),),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left : 10.0),
                           child: Text("1.5 km"),
                         )
                       ],
                     ),
                 Row(
                   children: <Widget>[
                     Icon((favorcolor) ? Icons.favorite : Icons.favorite_border, color: Color.fromRGBO(234, 98, 209, 1.0),),
                     Padding(
                       padding: const EdgeInsets.only (left : 5.0),
                       child: Text( (record.favorid!=null) ? record.favorid.length.toString() : '0' , ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left : 30.0),
                       child: Text("후기  5"),
                     )

                     ]
                 )

                   ],
                 ),
               ),
             ),
           )

          ]),
        ));
  }
}

Widget shopclass_show(Record_loca record) {
  String abc='';
  record.shop_class.forEach((a) {
      abc = abc + a+'/';
  });
  return Container(
      width: 180.0,
      child: Text(abc, style: TextStyle(color: Color.fromRGBO(234, 98, 209, 1.0)),));
}



