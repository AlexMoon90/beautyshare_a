import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'package:beautyshare_a/Model/model_user.dart';
import 'package:beautyshare_a/User.dart';
import 'package:beautyshare_a/Usage/Usage_review.dart';
import 'package:beautyshare_a/Model/model_review.dart';



class favorite_review extends StatelessWidget {
final List favorreview;
final ScrollController listcontroll ;
final double height ;
favorite_review(this.favorreview, this.listcontroll, this.height);

  @override
  Widget build(BuildContext context) {

    var data_fr = UserProvider.of(context).bloc;

    Widget favor_rev (Map favor, User user) {
       String displayName = favor['displayName'];
       String service = favor['service'];
       String profilephoto = favor['profilephoto'];
       String photo = favor['photo'];
       DocumentReference reference = favor['refrence'];

       return
         StreamBuilder(
             stream: reference.snapshots(),
             builder: (context, snapshot) {
               if(!snapshot.hasData) { return Text("") ;}
                 else {

               var ref = Record.fromsnapshot(snapshot.data);
               return GestureDetector(
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context) => usageReview(ref, user)));
                 },
                 child: Card(
                   margin: EdgeInsets.all(0.0),

                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0)),
                   elevation: 8.0,
                   child: Stack(
                     alignment: Alignment(-0.9, 0.9),
                     children: <Widget>[
                       Center(
                         child: Container(

                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(15.0),
                             child: Image.network(photo, fit: BoxFit.contain,),
                           ),
                         ),
                       ),

                 Container(
                   color: Color.fromRGBO(70, 70, 70, 0.4 ),
                   child: Row(
                     children: <Widget>[
                       Container(
                         height: 20.0,
                         width: 20.0,
                         decoration: BoxDecoration(
                             image: DecorationImage(image: NetworkImage(
                                 profilephoto),
                               fit: BoxFit.cover,),
                             borderRadius: BorderRadius.all(
                                 Radius.circular(75.0))
                         ),
                       ),
                       Expanded(
                           child: Padding(
                             padding: const EdgeInsets.only(left: 5.0),
                             child: Container(
                                 width: 15.0,
                                 child: Text(displayName,
                                   overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white),)),
                           )),

                       Text(service,style: TextStyle(color: Colors.white) ),
                     ],
                   ),
                 ),
                     ],
                   ),
                 ),
               ) ;

             }});

    }

    return
      GridView.count(
            controller: listcontroll,
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.8,
            children: List.generate((height==0.0) ? 0 : favorreview.length, (index){
              return favor_rev(favorreview[index], data_fr);

            }),
          );
        ;
  }
}




