import 'package:flutter/material.dart';
import 'package:beautyshare_a/Model/model_stylist.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/Usage/Usage_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/fancyButton.dart';
import 'Reservation.dart';


class stylistinfo extends StatelessWidget {
  final Record_stylist stylist;
  final Record_loca shopinfo;

  stylistinfo(this.shopinfo, this.stylist);
  Stream<QuerySnapshot> ref_uage = Firestore.instance.collection("Review").snapshots();


  @override
  
  Widget build(BuildContext context) {
    // TODO: implement build
  
    return  Scaffold(

      floatingActionButton: Fancybutton2("예약하기",() {
        Navigator.push(context, MaterialPageRoute(
            builder: (cotext1) => reservation(shopinfo)));
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black87,), onPressed: ()=> Navigator.pop(context)),
        title:  Text(stylist.name+" "+stylist.position, style: TextStyle(color: Colors.black87),),
      ),

      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left : 8.0, top : 15.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left : 25.0),
                  child: Container(

                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(
                            stylist.photo),
                          fit :   BoxFit.cover,),
                        borderRadius: BorderRadius.all(Radius.circular(75.0))
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal : 25.0),
                    child: Container(
                    //  width: 220.0,
                        child: Text(stylist.intro, ),  ),
                  ),
                ),


              ],

            ),
            ),
          Divider(),

          Expanded(
            child: Container(
              child: usage_list(ref_uage, 9, 3),
            ),
          )



        ],


      ),
      
      
    );
  }
  
}
