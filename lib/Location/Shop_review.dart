import 'package:flutter/material.dart';
import 'Location_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/model_stylist.dart';
import 'package:beautyshare_a/Model/model_review.dart';
import 'package:beautyshare_a/Usage/Usage_review.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/Usage/Usage_list.dart';
import 'Stylist.dart';
import 'package:beautyshare_a/fancyButton.dart';


class shopreview extends StatelessWidget {
  final Record_loca shopinfo;

  shopreview(this.shopinfo );

  Stream<QuerySnapshot> ref_uage = Firestore.instance.collection("Review").snapshots();

  @override

  Widget build(BuildContext context) {
    Stream<QuerySnapshot> Stylist = shopinfo.reference.collection("stylist").snapshots();


    // TODO: implement build
    return
        Column(
          children: <Widget>[

             StreamBuilder(
                 stream: Stylist,
                 builder: (context, snapshot){


      if (!snapshot.hasData)
            return Center(child: Container(
               width: 50.0,
               height: 50.0,
               child: CircularProgressIndicator()));

      return (snapshot.data.documents.length!=0) ? Column( children : [ Container(
        height: 150.0,
        child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              scrollDirection: Axis.horizontal,
              primary: true,
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 0.0),
              itemBuilder: (context, index) =>
                 StylistTile(snapshot.data.documents[index], shopinfo),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left : 20.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(" 디자이너를 선택하시면 디자이너별 후기를 보실 수 있습니다", style: TextStyle(fontSize: 13.0),)),
          ],
        ),
      ),
      ] )
          : Container(height: 0.0,);  // 직원 데이타가 없으면 직원을 볼 수 있는 자리를 없앰.

    } ),


            Divider(),
            Row(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left : 20.0, top: 10.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text("샵 전체 후기 ", style: TextStyle(fontSize: 18.0),),

                    ],
                  ),
                )

              ],
            ),
            Divider(),

            Container(
              height: 500.0,
              child: usage_list(ref_uage,9,3),
            )


          ],

      );
  }
}

class StylistTile extends StatelessWidget {

  final DocumentSnapshot data;
  final Record_loca shopinfo;
    StylistTile(this.data, this.shopinfo);

    @override
  Widget build(BuildContext context) {
      var stylist_infor = Record_stylist.fromsnapshot(data);
     var stylist_id =  stylist_infor.reference.documentID;

    return

      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (cotext1) => stylistinfo(shopinfo, stylist_infor)));
        },
        child: Container(
          height: 100.0,
          width: 100.0,

          child: Column(
            children: <Widget>[

            Container(

            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(
                    stylist_infor.photo),
                  fit :   BoxFit.cover,),
                borderRadius: BorderRadius.all(Radius.circular(75.0))
            ),
          ),
              Padding(
                padding: const EdgeInsets.only(top : 8.0),
                child: Text(stylist_infor.name+" "+stylist_infor.position, textAlign: TextAlign.center, style: TextStyle(fontSize: 13.0),),
              ),
            ],
          ),
        ),
      )
      ;
  }

}




