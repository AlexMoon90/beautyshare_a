import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'package:beautyshare_a/Model/model_user.dart';
import 'package:beautyshare_a/User.dart';
import 'package:beautyshare_a/Usage/Usage_review.dart';
import 'package:beautyshare_a/Model/model_review.dart';
import 'package:beautyshare_a/Location/Location_infor.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';



class favorite_shop extends StatelessWidget {
  final List favorshop;
  final ScrollController listcontroll ;
  final double height ;

  favorite_shop(this.favorshop, this.listcontroll, this.height);

  @override
  Widget build(BuildContext context) {

    var data_fr = UserProvider.of(context).bloc;

    Widget favor_rev (Map favor, User user) {
      String title = favor['title'];
      List service = favor['service'];
      String photo = favor['photo'];
      DocumentReference reference = favor['refrence'];

      return
        StreamBuilder(
            stream: reference.snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData) { return Text("") ;}
              else {
                var ref = Record_loca.fromsnapshot(snapshot.data);
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => locationinfor(ref, user,1)));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 8.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 250.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(photo),
                        ),
                      ),

                      Expanded(
                        child: Container(
                            width: 100.0,
                            child: Text(title, style: TextStyle(fontSize: 18.0),
                              overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                      ),
                      Expanded ( child :
                      shopclass_show(service),
                      )


                    ],
                  ),
                ),
              ) ;

            }});

    }

    return
      GridView.count(
        controller: listcontroll,
        crossAxisCount: 2,
        shrinkWrap: true,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.93,
        children: List.generate((height==0.0)? 0 : favorshop.length , (index){
          return favor_rev(favorshop[index], data_fr);

        }),
      );
    ;
  }
}

Widget shopclass_show(List service) {
  String abc='';
  service.forEach((a) {
    abc = abc + a+'/';
  });
  return Container(
      width: 80.0,
      child: Text(abc, style: TextStyle(color: Color.fromRGBO(234, 98, 209, 1.0)), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,));
}


