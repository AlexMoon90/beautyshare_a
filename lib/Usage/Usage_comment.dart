import 'package:flutter/material.dart';
import 'package:beautyshare_a/Model/model_review.dart';
import 'package:beautyshare_a/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class commentpage extends StatefulWidget {
  final Record _record;
  final User _user;
  commentpage(this._record, this._user);
  @override
  _commentpageState createState() => _commentpageState();
}

class _commentpageState extends State<commentpage> {
 Stream<QuerySnapshot> comment_data;
 @override

 bool mainornot;
 bool mine;
 FocusNode myFocusNode;
 FocusNode noFocusNode;
 DocumentReference comm_refrence;
  void initState() {
   comment_data = widget._record.reference.collection("Comment").orderBy("timestamp").snapshots();
   mainornot = true;
   myFocusNode = FocusNode();
   noFocusNode = FocusNode();
   mine = false;
   super.initState();
  }
 TextEditingController tedit = TextEditingController();
  String answerid ;



 Widget Comment_fuction (Comment_field _docu) {

   var posttime = DateTime.now().difference(_docu.timestamp);
   String elaptime;
   if (posttime.inHours < 1) {
     elaptime = posttime.inMinutes.toString() + " 분";
   } else if (posttime.inHours < 24) {
     elaptime = posttime.inHours.toString() + " 시간";
   } else if (posttime.inHours >= 24) {
     elaptime = posttime.inDays.toString() + " 일";
   } else if (posttime.inDays >= 30) {
     elaptime = (posttime.inDays % 30).toString() + " 개월";

   }
   return
     Padding(
       padding: (_docu.mainor) ? const EdgeInsets.only(left :  10.0, right : 10.0, top : 25.0, ) : const EdgeInsets.only(left :  45.0, right : 10.0, top : 5.0) ,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[

           Padding(
             padding: const EdgeInsets.only (right : 15.0),
             child: Container(
               height: 30.0,
               width: 30.0,
               decoration: BoxDecoration(
                   image: DecorationImage(
                     image: NetworkImage(
                         _docu.photoUrl),
                     fit: BoxFit.cover,),
                   borderRadius: BorderRadius.all(
                       Radius.circular(75.0))
               ),
             ),
           ),

           Expanded(
             child: Container(
               decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),

               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Container(
                     child: Column(
                       children: <Widget>[
                         Text(_docu.displayName),
                         Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: Text(_docu.content),
                         )
                       ],
                       crossAxisAlignment: CrossAxisAlignment.start,
                     ),
                   ),

                   Container(
                     color: Colors.white,
                     child: Row(children: <Widget>[
                       Text(elaptime+"전", style: TextStyle(fontSize: 12.0, color: Colors.black54),),
                       Padding(
                         padding: const EdgeInsets.only (left : 8.0),
                         child: GestureDetector(
                             onTap: () {

                               setState(() {
                               tedit.text = _docu.displayName + "  "; /* 답글일 경우 입력창 앞에 닉네임이 자동으로 입력하게 만듬 */
                               FocusScope.of(context).requestFocus(myFocusNode);
                               mainornot = false;
                               answerid = (_docu.mainor) ? _docu.reference.documentID : _docu.comm_id ;  /* 메인글의 id를  입력해야 메인글의 답글로 붙는데, 메인글은 documnet ID를 답글인 경우 comm_id 사용 */

                             }); },
                             child: Text ('답글달기', style: TextStyle(fontSize: 12.0, color: Colors.black))),

                       ),
                     (_docu.email==widget._user.email) ?  /* 내가 쓴 글인지 확인후에 수정 과 삭제가 보여지도록 함 */
                      Row( children : [ Padding(
                        padding: const EdgeInsets.only( left : 8.0),
                        child: GestureDetector (onTap: () {
                          setState(() {
                            comm_refrence = _docu.reference;
                            tedit.text = _docu.content;
                            FocusScope.of(context).requestFocus(myFocusNode);
                            mine = true;
                          });
                        }, child: Text ('수정', style: TextStyle(fontSize: 12.0, color: Colors.black))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left : 8.0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if(_docu.mainor) {
                                  _docu.reference.delete();
                                  widget._record.reference.collection("Comment")
                                      .where("comm_id",
                                      isEqualTo: _docu.reference.documentID);
                                } else {  _docu.reference.delete();
                                }

                              });

                            },
                            child: Text ('삭제', style: TextStyle(fontSize: 12.0, color: Colors.black))),
                      )


                      ])

                         : Container(),

                     ],),
                   )
                 ],
               ),
             ),
           ),


         ],
       ),
     );


 }


  @override
  Widget build(BuildContext context) {

    var c_refer = widget._record.reference;


    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon( Icons.keyboard_arrow_left), color: Colors.black, onPressed: ()=>Navigator.pop(context),),
        title:  Text('댓글남기기', style: TextStyle(color: Colors.black),), backgroundColor: Colors.white, ),


      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left : 20.0),
        child: Container(
          color: Colors.white,
          child: Row(

            children: <Widget>[
              Expanded(
                child: Container(
                    color: Colors.white,
                    child :
                TextFormField(

                  focusNode: myFocusNode,
                  textInputAction: TextInputAction.done,
                  controller: tedit,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(),
                      labelText: '댓글을 입력해주세요'),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                child: GestureDetector(child: Text('게시', ), onTap: () async {
                 if (mine==false) {
                  var reference = c_refer.collection("Comment");
                  reference.add({
                    "displayName" : widget._user.displayName,
                    "email" : widget._user.email,
                    "photoUrl" : widget._user.photoUrl,
                    "timestamp" : Timestamp.now(),
                    "mainor" : mainornot,
                    "comm_id" : answerid,
                    "content" : tedit.text,
                  }).whenComplete(()=> setState(() {
                    tedit.text="";
                    answerid="";
                    FocusScope.of(context).requestFocus(noFocusNode);

                  }) );
                } else if (mine==true) {


                   comm_refrence.updateData({"content" : tedit.text}).whenComplete(() => setState(() {
                     tedit.text="";
                     answerid="";
                     mine=false;

                     FocusScope.of(context).requestFocus(noFocusNode);

                   }) );
                 }

                },


                ) ,
              )
            ],
          ),
        ),
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body : Padding(
        padding: const EdgeInsets.only(bottom : 80.0),
        child: StreamBuilder(
            stream: comment_data,
            builder: (context, snapshot){
              if (!snapshot.hasData) return Container();

              List <Comment_field> comment_a = [];
              List <Comment_field> comment_b = [];
              List <Comment_field> comment_c = [];
              List <Comment_field> comment_d = [];

              for (int i=0; i < snapshot.data.documents.length ; i++) {
                comment_a.add(Comment_field.fromsnapshot(snapshot.data.documents[i]));
                if(comment_a[i].mainor==true) { comment_b.add(comment_a[i]); }
                else if (comment_a[i].mainor==false) { comment_c.add(comment_a[i]); }
              }

              for (int i=0; i < comment_b.length ; i++) {
                comment_d.add(comment_b[i]);
                for (int j=0; j < comment_c.length ; j++) {
                  if (comment_c[j].comm_id == comment_b[i].reference.documentID) comment_d.add(comment_c[j]);
                }
              }

              return ListView.builder(
                itemCount: comment_d.length,
                primary: true,
                padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 8.0, bottom: 0.0),
                itemBuilder: (context, index) =>
                    Comment_fuction(comment_d[index]),
              );
            }),
      ),
    );


  }
}



class commentTile extends StatelessWidget {
  final Comment_field _docu;
  commentTile (this._docu);

  @override
  Widget build(BuildContext context) {
    print(_docu.mainor);
    var posttime = DateTime.now().difference(_docu.timestamp);
    String elaptime;
    if (posttime.inHours < 1) {
      elaptime = posttime.inMinutes.toString() + " 분";
    } else if (posttime.inHours < 24) {
      elaptime = posttime.inHours.toString() + " 시간";
    } else if (posttime.inHours >= 24) {
      elaptime = posttime.inDays.toString() + " 일";
    } else if (posttime.inDays >= 30) {
      elaptime = (posttime.inDays % 30).toString() + " 개월";

    }
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: (_docu.mainor) ? const EdgeInsets.only(left :  0.0, right : 10.0, top : 25.0, ) : const EdgeInsets.only(left :  25.0, right : 10.0, top : 25.0) ,
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        _docu.photoUrl),
                    fit: BoxFit.cover,),
                  borderRadius: BorderRadius.all(
                      Radius.circular(75.0))
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                  child: Column(
                    children: <Widget>[
                      Text(_docu.displayName),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(_docu.content),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),

              Row(children: <Widget>[
                Text(elaptime+"전", style: TextStyle(fontSize: 12.0, color: Colors.black54),),
                Padding(
                  padding: const EdgeInsets.only (left : 8.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text ('답글달기', style: TextStyle(fontSize: 12.0, color: Colors.black))),
                ),

              ],)
              ],
            ),
          ),


        ],
      );


  }
}

class Comment_field {
  final String displayName;
  final String email;
  final String photoUrl;
  final String content;
  final DateTime timestamp;
  final bool mainor;
  final String comm_id ;
  final DocumentReference reference;


  Comment_field.fromMap(Map <String, dynamic > map, {this.reference}) :
        displayName = map["displayName"],
        email = map["email"],
        photoUrl = map["photoUrl"],
        content = map["content"],
        timestamp = map["timestamp"],
        mainor = map["mainor"],
        comm_id = map["comm_id"];

      Comment_field.fromsnapshot (DocumentSnapshot snapshot)
      : this.fromMap (snapshot.data, reference :snapshot.reference) ;
}
