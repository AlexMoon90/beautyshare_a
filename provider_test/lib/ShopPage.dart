import 'package:flutter/material.dart';
import 'AddressSearch.dart';
import 'Bloc_database.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Bloc_mylocation.dart';
import 'Bloc_googleaddress.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'MapPage.dart';
import 'MapPage_total.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> {
  Bloc_database bloc;
  Bloc_mylocation loca;
  Bloc_googleaddress addrr;
  var autosize1, autosize2;
  bool longtap;
  String dropdownValue;
  Color buttontextColor;
  List<Model_shopinfor> list_bloc;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
   bloc = Provider.of<Bloc_database>(context, listen: false);
    loca = Provider.of<Bloc_mylocation>(context, listen: false);
    addrr = Provider.of<Bloc_googleaddress>(context, listen: false);
    addrr.search_address(loca.mylocation);
   bloc.Get(loca.mylocation, '1.5 km');
    autosize1 = AutoSizeGroup();
    autosize2 = AutoSizeGroup();
    longtap = false;
    dropdownValue = '1.5 km';
    buttontextColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.toString());



    return Scaffold(
        appBar: AppBar(
          title: Text('가게정보'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    loca.getcurrent();
                    addrr.search_address(loca.mylocation);
                  },
                  child: StreamBuilder(
                      stream: addrr.adress_observer,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Container();
                        else if (snapshot.hasData) {
                          return AutoSizeText(snapshot.data,
                              minFontSize: 10.0,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted));
                        }
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top : 5.0),
              child: DropdownButton<String>(
                style: TextStyle(color: Colors.white),

                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    bloc.Get(loca.mylocation, newValue);
                  });
                },
                items: <String>['1.5 km', '3 km', '5 km', '10 km']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(

                    value: value,
                    child: Text(value, style : TextStyle(
                        color: Colors.black,
                        decorationColor: Colors.white)),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
                child: Icon(Icons.map),
                onPressed: () async {
                  double distance;
                  switch(dropdownValue) {
                    case "1.5 km": {
                     distance = 15.0;
                    }
                    break;

                    case "3 km": {
                     distance = 14.0;
                    }
                    break;

                    case "5 km": {
                    distance = 13.0;

                    }
                    break;

                    case "10 km": {
                      distance = 12.0;

                    }
                    break;

                  }

                  var list = bloc.Get(loca.mylocation, dropdownValue);


                  

                 /* Future.delayed(Duration(seconds: 1), () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) { MapPage_total(list, distance); }) );   }); */

                 bloc.Get(loca.mylocation, dropdownValue).then((a) { Navigator.push(context,
                     MaterialPageRoute(builder: (context) => MapPage_total(a, distance))); });

                  ;}),

            FloatingActionButton(
              heroTag: '12345',
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddressSearch()))),
          ],
        ),
        body: StreamBuilder(
          stream: bloc.shop_observe,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();

            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Model_shopinfor model = snapshot.data[index];
                    var imageurl = model.photo==null ? null :
                        "${bloc.photourl}${model.photo}&key=${bloc.kGoogleApiKey}";
                    var touchadd = Tilestate();
                    touchadd.touch = false;
                    BehaviorSubject iftouch = BehaviorSubject();

                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
                      child: StreamBuilder(
                          initialData: touchadd,
                          stream: iftouch.stream.where((a) => a.index == index),
                          builder: (context, snapshot) {
                            Tilestate aaa = snapshot.data;
                            if (!aaa.touch) {


                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapPage(model))),
                                onLongPress: () {
                                  touchadd.index = index;
                                  touchadd.touch = true;
                                  iftouch.add(touchadd);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          child: model.photo == null
                                              ? Icon(
                                                  Icons.home,
                                                  size: 100.0,
                                                  color: Colors.lightBlue,
                                                )
                                              : FadeInImage.memoryNetwork(
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: imageurl),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 7.0,
                                              bottom: 7.0),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: AutoSizeText(
                                                          model.name,
                                                          maxFontSize: 20.0,
                                                          presetFontSizes: [
                                                            20.0,
                                                            19.0,
                                                            18.0,
                                                            17.0,
                                                            16.0,
                                                            14.0
                                                          ],
                                                          group:
                                                              AutoSizeGroup(),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                    AutoSizeText(
                                                      "${model.dis > 10 ? (model.dis).toStringAsFixed(0) : (model.dis).toStringAsFixed(1)}km",
                                                      maxFontSize: 15.0,
                                                      presetFontSizes: [
                                                        13.0,
                                                        12.0,
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(model.phone),
                                                Container(
                                                  child: AutoSizeText(
                                                      model.address,
                                                      maxLines: 2,
                                                      minFontSize: 10.0,
                                                      group: autosize2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (aaa.touch) {
                              return Stack(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Container(
                                            height: 90,
                                            width: 90,
                                            child: imageurl == null
                                                ? Icon(
                                                    Icons.home,
                                                    size: 100.0,
                                                    color: Colors.lightBlue,
                                                  )
                                                : FadeInImage.memoryNetwork(
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        kTransparentImage,
                                                    image: imageurl),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0,
                                                right: 15.0,
                                                top: 7.0,
                                                bottom: 7.0),
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: AutoSizeText(
                                                            model.name,
                                                            maxFontSize: 20.0,
                                                            presetFontSizes: [
                                                              20.0,
                                                              19.0,
                                                              18.0,
                                                              17.0,
                                                              16.0,
                                                              14.0
                                                            ],
                                                            group:
                                                                AutoSizeGroup(),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        "${model.dis > 10 ? (model.dis).toStringAsFixed(0) : (model.dis).toStringAsFixed(1)}km",
                                                        maxFontSize: 15.0,
                                                        presetFontSizes: [
                                                          13.0,
                                                          12.0,
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Text(model.phone),
                                                  Container(
                                                    child: AutoSizeText(
                                                        model.address,
                                                        maxLines: 2,
                                                        minFontSize: 10.0,
                                                        group: autosize2),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26.withOpacity(0.5),
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.grey.shade100,
                                                  size: 30.0,
                                                ),
                                                onPressed: () {
                                                  touchadd.touch = false;
                                                  iftouch.sink.add(touchadd);
                                                })
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              RaisedButton(
                                                onPressed: () {},
                                                child: Text('수   정'),
                                              ),
                                              RaisedButton(
                                                  child: Text('삭   제'),
                                                  onPressed: () {
                                                    touchadd.touch = false;
                                                    iftouch.sink.add(touchadd);
                                                    bloc.Delete(model.id);
                                                    bloc.Get(loca.mylocation);
                                                  })
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }
                          }),
                    );
                  });
          },
        ));
    // TODO: Implement build
  }
}

class Tilestate {
  bool touch;
  int index;
}
