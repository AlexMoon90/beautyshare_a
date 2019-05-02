import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/model_promotion.dart';

class promotion_list extends StatelessWidget {
  final Stream<QuerySnapshot> doc;
  promotion_list(this.doc);

  @override

  Widget build(BuildContext context) {


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
                promotiontile(snapshot.data.documents[index]),
          );
        });
  }
}

class promotiontile extends StatelessWidget {
  final DocumentSnapshot documnet ;
  promotiontile(this.documnet);
  @override
  Widget build(BuildContext context) {

    var Prinform = Record_pr.fromsnapshot(documnet);

    return  ExpansionTile(
      initiallyExpanded: false,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left : 5.0),
              child: Container(
                constraints: BoxConstraints.tight( Size.square(80.0)),

                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'Loading_icon.gif',
                    image: Prinform.shopphoto,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only ( left : 10.0 , right : 5.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(Prinform.prtitle, style: TextStyle(fontSize: 18.0),),
                      Text(Prinform.shoptitle, style: TextStyle(fontSize: 16.0, color:  Color.fromRGBO(234, 98, 209, 1.0)),),

                    ],
                  ),
                ),
              ),
            ),

          ],
        )
      ),



      children: [

        Padding(
          padding: const EdgeInsets.only(left : 20.0, top :10.0, right: 20.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("ㅇ 대 상 :  ${Prinform.prwho}" ,),
              Text("ㅇ 기 간 :  ${Prinform.startday.year}.${Prinform.startday.month}.${Prinform.startday.day} ~ ${Prinform.endday.month}.${Prinform.endday.day}",),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text ("ㅇ 내 용 :"),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(child: Text (Prinform.prcontent)),
                  ))
                ],
              ),
              Text("ㅇ 참 고 : ${Prinform.pretc}")
            ],
          ),
        ),

      ],
    );;
  }


}
