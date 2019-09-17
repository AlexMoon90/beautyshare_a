import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'CartPage.dart';
import 'Page.dart';
import 'BlocCart.dart';
import 'AddressSearch.dart';
import 'ShopPage.dart';
import 'Bloc_mylocation.dart';
import 'Bloc_database.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Bloc_color bloc;
  Bloc_cart bloccart;
  Bloc_avatar blocavar;
  Bloc_mylocation blocator;
  Bloc_database bloc_database;

  TabController tabController;
  PageStorageKey pageStorageKey;
  PageStorageKey pageStorageKey2;
  ScrollController scrollController;
  ScrollController scrollController2;
  List<Widget> testwidget = [];
  double opacity, height_navi;
  bool appState;
  double screenWidth;
  double screenHight;
  void initState() {
    // TODO: implement initState

    super.initState();
    appState = true;
    bloc = Provider.of<Bloc_color>(context, listen: false);
    bloccart = Provider.of<Bloc_cart>(context, listen: false);
    blocavar = Provider.of<Bloc_avatar>(context, listen: false);
    blocator = Provider.of<Bloc_mylocation>(context, listen: false);
    bloc_database = Provider.of<Bloc_database>(context, listen: false);
    opacity = 1.0;

    tabController = TabController(length: 2, vsync: this);
    //  tabController.animateTo(0,duration: Duration(microseconds: 0), curve: Curves.ease);
    //  tabController.previousIndex;
    pageStorageKey = PageStorageKey('color');

    tabController.animation.addListener(buttonChange);

    scrollController = ScrollController();
    // scrollController.animateTo(0.0, duration: Duration(milliseconds: 0), curve: Curves.ease);
    scrollController.addListener(scrollchange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.disclose();
    bloccart.disclose();
    blocavar.disclose();
  }

  void scrollchange() {}

  void buttonChange() {
    int index;
    if (tabController.animation.value >= 0.0 &&
        tabController.animation.value < 0.5) {
      index = 0;
      bloc.buttonchange(index);
    } else if (tabController.animation.value > 0.5 &&
        tabController.animation.value <= 1.0) {
      index = 1;
      bloc.buttonchange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    blocator.getfirst();
    bloc_database.Create();
    screenHight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth * 0.07;
    height_navi = screenHight * 0.075;

    print(MediaQuery.of(context).size);

    Widget Color_list = StreamBuilder(
      stream: bloc.colobserve,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasData) {
          return ListView.builder(
            key: PageStorageKey('color'),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                bloccart.coloraddcart(snapshot.data[index]);
                bloc.color_change(snapshot.data[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      color: snapshot.data[index],
                    ),
                    Text(snapshot.data[index].toString()),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );

    Widget Avar_list = StreamBuilder(
        stream: blocavar.avarobserve,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              key: PageStorageKey('avar'),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    bloccart.avaraddcart(snapshot.data[index]['avartar'],
                        snapshot.data[index]['name']);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AvataaarImage(
                          avatar: snapshot.data[index]['avartar'],
                          errorImage: Icon(Icons.error),
                          placeholder: CircularProgressIndicator(),
                          width: 80.0,
                        ),
                        Text(snapshot.data[index]['name']),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });

    return Scaffold(
      body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              StreamBuilder(
                  initialData: Colors.blue,
                  stream: bloc.color_observe,
                  builder: (context, snapshot) {
                    return SliverAppBar(
                        centerTitle: false,
                        snap: true,
                        floating: true,
                        pinned: true,
                        expandedHeight: 150.0,
                        //  forceElevated: true,
                        backgroundColor: snapshot.data,
                        bottom: TabBar(
                            indicatorColor: snapshot.data,
                            controller: tabController,

                            /* onTap: (i){ indexx=i;
                      print(indexx);}, */
                            tabs: [
                              Tab(
                                text: '칼라리스트',
                              ),
                              Tab(
                                text: '아바타리스트',
                              ),
                            ]),
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.card_giftcard, size: 15.0 ,),
                            SizedBox(width: 10.0,),
                            Text(
                              widget.title, style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
                            ),
                          ],
                        ),
                        actions: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 5.0, top: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage()));
                              },
                              child: Stack(
                                textDirection: TextDirection.ltr,
                                alignment: Alignment(0.2, -0.7),
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.amber,
                                    size: 25.0,
                                  )),
                                  StreamBuilder(
                                      stream: bloccart.cartobserve,
                                      builder: (context1, snapshot) {
                                        if (!snapshot.hasData)
                                          return Container();
                                        else if (snapshot.hasData)
                                          return snapshot.data.length == 0
                                              ? Container()
                                              : Hero(
                                                  tag: "fine",
                                                  child: Stack(
                                                    alignment:
                                                        Alignment(0.0, 0.0),
                                                    children: <Widget>[
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                        width: 13.0,
                                                        height: 13.0,
                                                      ),
                                                      Text(
                                                        '${snapshot.data.length}',
                                                        style: TextStyle(
                                                            fontSize: 7.0,
                                                            decorationStyle:
                                                                TextDecorationStyle
                                                                    .double),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ]);
                  }),
            ];
          },
          body: TabBarView(
              controller: tabController, children: [Color_list, Avar_list])),
      /*  body: TabBarView(
            // key: pageStorageKey ,
            controller: tabController,
            children: [Color_list, Avar_list]),*/
      floatingActionButton: Container(
        height: 150.0,
        child: StreamBuilder(
            stream: bloc.buttonobserve,
            builder: (context, snapshot) {
              Color color;
              ShapeBorder shape;
              if (snapshot.data == 0) {
                shape = CircleBorder();
              } else if (snapshot.data == 1) {
                color = Colors.red;
                shape = RoundedRectangleBorder();
              }

              return StreamBuilder<Object>(
                  stream: bloc.color_observe,
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: FloatingActionButton(
                            heroTag: 'joon',
                            backgroundColor: snapshot.data,
                            shape: shape,
                            onPressed: () {
                              if (tabController.index == 0) {
                                bloc.makewidgetlist();
                                Timer(Duration(milliseconds: 100),
                                    () => scrollController.jumpTo(0.0));
                              } else if (tabController.index == 1) {
                                blocavar.makeAvatar();
                                Timer(Duration(milliseconds: 100),
                                    () => scrollController.jumpTo(0.0));
                              }
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: 'moon',
                          shape: shape,
                          backgroundColor: snapshot.data,
                          onPressed: () {
                            if (tabController.index == 0) {
                              bloc.deletelist();
                            } else if (tabController.index == 1)
                              return blocavar.delAvatar();
                          },
                          child: Icon(Icons.remove),
                        ),
                      ],
                    );
                  });
            }),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: height_navi,
        child: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.home), onPressed: null),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShopPage()))),
            ],
          ),
        ),
      ),
    );
  }
}
