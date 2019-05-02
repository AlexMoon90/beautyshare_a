import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beautyshare_a/Model/model_review.dart';
import 'Usage_writing.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:beautyshare_a/Model/User_Provider.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/User.dart';
import 'package:beautyshare_a/Location/Location_infor.dart';
import 'package:beautyshare_a/Model/model_shopinfo.dart';
import 'package:beautyshare_a/Usage/Usage_comment.dart';

class usageReview extends StatefulWidget {
  final Record rec;
  final User cuser;
  usageReview(this.rec, this.cuser);


  _usageReviewState createState() {
    return _usageReviewState();
  }
}

class _usageReviewState extends State<usageReview> {

  Stream<DocumentSnapshot> ref_loca = Firestore.instance.collection("Beautyshop").document('shop2').snapshots();
  BoxFit boxchange;
  double conheight;
  bool favorpro = false;
  bool favorcolor;
  int favornum;
  DocumentReference revewid;
  TextEditingController comment_controller;
  


  void initState()  {
    // TODO: implement initState
    super.initState();
    boxchange = BoxFit.cover;
    conheight = 300.0;
    favornum = (widget.rec.favorid != null)
        ? widget.rec.favorid.length
        : 0; // 좋아요를 누른 사용자리스트의 숫자를 세어서 토탈 수를 계산함.
    revewid= widget.cuser.reference;
    if (widget.rec.favorid == null) {
      favorcolor = false;
    } else if (widget.rec.favorid.contains(revewid)==true) {
      favorcolor = true;
    } else if (widget.rec.favorid.contains(revewid) == false) {
      favorcolor = false;
    } }



    GestureDragUpdateCallback gestureDragUpdateCallback;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var cuser = UserProvider.of(context).bloc;

    // 리뷰의 등록후 경과시간을 분, 시간, 일, 개월로 구분하여 보여줌
    var posttime = DateTime.now().difference(widget.rec.timestamp);
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
    var sdis = widget.rec.distance.toStringAsFixed(1);
    var bdis = widget.rec.distance.round();


        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white, /* Colors.pinkAccent[100].withOpacity(0.5)   Color.fromRGBO(70, 70, 70, 0.5), // Color.fromRGBO(234, 98, 209, 1.0), */
            leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () => Navigator.pop(context)),

            title: Text(
              "이용후기 상세정보",
              style: TextStyle(fontSize: 20.0, color: Colors.black ),
            ),
          ),
          body:

              ListView(children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (boxchange == BoxFit.cover) {
                          boxchange = BoxFit.contain;
                          conheight = 600.0;
                        } else {
                          boxchange = BoxFit.cover;
                          conheight = 300.0;
                        }
                      });
                    },
                    onVerticalDragUpdate: (gestureDragUpdateCallback) {
                      setState(() {
                        boxchange = BoxFit.cover;
                        conheight = 300.0;
                      });
                    },
                    // {Navigator.push(context, MaterialPageRoute(builder: (context) => usage_imagepage(widget.rec, 0) ));},
                    child: AnimatedContainer(
                        duration: Duration(microseconds: 500000 ),
                        curve: Curves.easeInOut,
                        height: conheight,
                        width: 500.0,
                        child: Swiper(
                            itemBuilder: (context, index) {
                              return FadeInImage.assetNetwork(
                                placeholder: 'images/Loading_icon.gif',
                                image: widget.rec.photoUrl[index],
                                fit: BoxFit.cover,
                              );
                            },
                            indicatorLayout: PageIndicatorLayout.COLOR,
                            outer: false,
                            loop: false,
                            itemCount: 3,
                            pagination: SwiperPagination(
                                alignment: Alignment.bottomCenter,
                                builder: DotSwiperPaginationBuilder(
                                  activeColor: Color.fromRGBO(234, 98, 209, 1.0),
                                  color: Colors.white,
                                  size: 10.0,
                                  space: 10.0,
                                )),
                            control: new SwiperControl(
                                iconNext: null,
                                iconPrevious: null,
                                color: Colors.pink)))),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    
                    IconButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => commentpage(widget.rec, widget.cuser)));},
                        icon: ImageIcon(AssetImage('images/chat.png'), color: Color.fromRGBO(234, 98, 209, 1.0), size: 30.0,) ),
                    StreamBuilder(
                      stream: widget.rec.reference.collection("Comment").snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData) { return Text('0', style: TextStyle(fontSize: 20.0),);}
                        return Text(snapshot.data.documents.length.toString(), style: TextStyle(fontSize: 20.0),);
                      }
                    ),
                    
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: IconButton(
                        icon: ImageIcon(
                          (favorcolor) ? AssetImage('images/heart.png'): AssetImage('images/hear_b.png'),
                          size: 30.0,
                          color: Color.fromRGBO(234, 98, 209, 1.0), ),
                        onPressed: () async {
                          setState(() {
                            //좋아요 클리시 숫자 처리 및 데이타베이스 정보 수정 ( 좋아요 집계와 좋아요 누른 아이디 저장 및 삭제)
                            if (favorcolor) {
                              favorcolor = false;
                              favornum--;
                              //  widget.rec.reference.updateData({'favor_review' : favornum});
                              widget.rec.reference
                                  .updateData({
                                "favorid": FieldValue.arrayRemove(
                                    [revewid])
                              });

                              widget.cuser.reference
                                  .updateData({
                                "favorreview": FieldValue.arrayRemove(
                                    [{
                                      'displayName' : widget.rec.displayName,
                                      'service' : widget.rec.serv_class,
                                      'profilephoto' : widget.rec.photoUrl[0],
                                      'photo' : widget.rec.photoUrl[0],
                                      'refrence' : widget.rec.reference, // 이 리뷰의 레퍼런스를 저장해서 다른 위젯에서 여기로 다시 찾아올때 사용함
                                    }])
                              });


                            } else {
                              favorcolor = true;
                              favornum++;
                              //  widget.rec.reference.updateData({'favor_review' : favornum});
                              widget.rec.reference
                                  .updateData({
                                "favorid": FieldValue.arrayUnion(
                                    [revewid])
                              });

                              widget.cuser.reference
                                  .updateData({
                                "favorreview": FieldValue.arrayUnion(
                                    [{
                                      'displayName' : widget.rec.displayName,
                                      'service' : widget.rec.serv_class,
                                      'profilephoto' : widget.rec.photoUrl[0],
                                      'photo' : widget.rec.photoUrl[0],
                                      'refrence' : widget.rec.reference,

                                    }])
                              });

                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: Text(
                        favornum.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),

                  ],
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Stack(
                            children: <Widget>[
                              Container(

                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.rec.photoUrl[0]),
                                      fit: BoxFit.cover,),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(75.0))
                                ),
                              ),

                              // 뒷사진들을 미리 캐쉬에 다운받게 하되 보이지 않게 함.
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Opacity(opacity: 0.0,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'Loading_icon.gif',
                                    image: widget.rec.photoUrl[1],
                                    fit: boxchange,
                                  ),),
                              ),
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Opacity(opacity: 0.0,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'Loading_icon.gif',
                                    image: widget.rec.photoUrl[2],
                                    fit: boxchange,
                                  ),),)
                            ],
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          widget.rec.userid,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            elaptime + "전",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Stack(alignment: Alignment(-1.0, 1.0), children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0, right : 10.0, left : 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                             widget.rec.shoptitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text( (widget.rec.distance < 5.0) ?
                              "${sdis} km" : "$bdis km",
                              style: TextStyle(fontSize: 13.0), textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "이 샵의 다른후기",
                              style: TextStyle(fontSize: 13.0), textAlign: TextAlign.end,
                               ),
                          ),
                        IconButton(
                                 icon: Padding(
                                   padding: const EdgeInsets.only(
                                  right: 24.0, bottom: 15.0),
                                 child: Icon(
                                       Icons.keyboard_arrow_right,
                                        size: 40.0,
                                       color: Colors.black54,
                                           ),
                                             ),
                                    onPressed: () {  }
                                  ),




                   /*       StreamBuilder(
                            stream: ref_loca,
                            builder: (context, snapshot) {
                              var record = Record_loca.fromsnapshot(snapshot.data);
                            return IconButton(
                                icon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 24.0, bottom: 15.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 40.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                onPressed: () {

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (cotext) => locationinfor(record, cuser, 3 )));



                                }
                                    ); }
                          ), */

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 25.0),
                      child:  Text( (widget.rec.stylistpositoin!=null) ?'${widget.rec.stylistname} ${widget.rec.stylistpositoin}' : '${widget.rec.stylistname}' ,
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.start),
                    ),
                  ]),
                ),




                Container(
                  padding: EdgeInsets.only(
                      right: 25.0, left: 25.0, top: 15.0),
                  child: Text(
                    widget.rec.reviewtext,
                    softWrap: true,
                  ),
                ),
                Divider(),

              ]),
             /* Container(
                  height: 70.0,
                  child: AppBar(
                    backgroundColor: Colors.white, /* Colors.pinkAccent[100].withOpacity(0.5)   Color.fromRGBO(70, 70, 70, 0.5), // Color.fromRGBO(234, 98, 209, 1.0), */
                    leading: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        onPressed: () => Navigator.pop(context)),

                    title: Text(
                      "이용후기 상세정보",
                      style: TextStyle(fontSize: 20.0, color: Colors.black ),
                    ),
                  )
              ), */



          floatingActionButton: FloatingActionButton(
              highlightElevation: 10.0,
              elevation: 5.0,
              backgroundColor: Color.fromRGBO(234, 98, 209, 1.0),

              child: Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Usagewriting()));
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        );

      }
  }

