import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'Bloc_mylocation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:rxdart/rxdart.dart';
import 'Bloc_googleaddress.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'Bloc_mylocation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'Bloc_database.dart';
import 'package:after_init/after_init.dart';

class AddressSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddressSearchState();
  }
}

class AddressSearchState extends State<AddressSearch> {
  TextField searchtext;
  TextEditingController textcontroller_name;
  TextEditingController textcontroller_phone;
  TextEditingController textcontroller_address1;
  TextEditingController textcontroller_address2;
  Bloc_googleaddress goecoder;
  Bloc_database bloc;
  Bloc_mylocation blocator;

  String placeid;
  String photo;
  double long;
  double lat;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    goecoder = Provider.of<Bloc_googleaddress>(context, listen: false);
    bloc = Provider.of<Bloc_database>(context, listen: false);
    blocator = Provider.of<Bloc_mylocation>(context, listen: false);


    textcontroller_name = TextEditingController();
    textcontroller_address1 = TextEditingController();
    textcontroller_address2 = TextEditingController();
    textcontroller_phone = TextEditingController();


      }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textcontroller_name.text = null;
    textcontroller_name.dispose();

  }

  Future placesearch() async {
    // goecoder.search_address(query);

    const kGoogleApiKey = "AIzaSyDPQQKVeBdg--6A5n0J_7LMOH2PzpzY_j8";
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "ko",
      components: [Component(Component.country, "Kr")]
    );
    if (p.placeId != null) {
      var myplace = GoogleMapsPlaces(apiKey: kGoogleApiKey);
      var myplacedetail =
          await myplace.getDetailsByPlaceId(p.placeId, language: 'ko');
      placeid = p.placeId;
      textcontroller_address1.text = myplacedetail.result.formattedAddress.replaceAll('대한민국 ', '');
      textcontroller_name.text = myplacedetail.result.name;
      textcontroller_phone.text = myplacedetail.result.formattedPhoneNumber;
      long = myplacedetail.result.geometry.location.lng;
      lat = myplacedetail.result.geometry.location.lat;
      photo = myplacedetail.result.photos.first.photoReference;

      print (myplacedetail.result.photos.length);
    }
  }


  Future<void> _ackAlert(BuildContext context, bool aa) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var message1 = Text('이미 등록된 정보입니다 다시 정보를 검색해주세요', style: TextStyle(color: Colors.red),);
        var message2 = Text('성공적으로 정보가 등록이 되었습니다', style: TextStyle(color: Colors.blue),);

        return AlertDialog(
          // title: Text('Not in stock'),
          content: aa ? message1 : message2,
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                  setState(() {
                    textcontroller_name.clear();
                    textcontroller_phone.clear();
                    textcontroller_address1.clear();
                    textcontroller_address2.clear();

                  });


                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build



    searchtext = TextField(
      autofocus: false,
      controller: textcontroller_name,
    );
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
      appBar: AppBar(
            automaticallyImplyLeading: true,
          title: Text('주소 검색하기'),
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                  onTap: placesearch,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 50.0,
                        width: width * 0.8,
                        alignment: Alignment(-1.0, 0.5),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onTap: placesearch,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  textBaseline: TextBaseline.alphabetic),
                              hintText: '점포명 또는 건물명, 주소명으로 먼저 검색해주세요',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Icon(
                        Icons.input,
                        size: 30.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(height * 0.1)),
         ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('점 포 명 : '),
                  Container(
                      width: width * 0.6,
                      child: TextField(
                        autofocus: false,
                        controller: textcontroller_name,
                      ))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('전화번호 : '),
                  Container(
                      width: width * 0.6,
                      child: TextField(
                        autofocus: false,
                        controller: textcontroller_phone,
                      ))
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('주       소 : '),
                    Container(
                        width: width * 0.6,
                        child: TextField(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            autofocus: false,
                            controller: textcontroller_address1))
                  ]),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('상세주소 : '),
                  Container(
                      width: width * 0.6,
                      child: TextField(
                          autofocus: false,
                          controller: textcontroller_address2),
                          )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, right: 30.0, left: 30.0),
              child: Container(
                child: SizedBox(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.blue,
                    elevation: 8.0,
                    onPressed: () async {

                      var model = Model_shopinfor(
                          id: placeid,
                          name: textcontroller_name.text,
                          phone: textcontroller_phone.text,
                          address: textcontroller_address1.text +
                              textcontroller_address2.text,
                          photo: photo,
                          long: long,
                          lat:  lat
                      );

                     var duplicated = await bloc.Query(model);

                     if(duplicated == false) { _ackAlert(context, true ); }
                     else if(duplicated == true || duplicated==null) {
                      await bloc.Add(model);
                      await bloc.Get(blocator.mylocation).whenComplete(()=> _ackAlert(context, false) );;
                     }
                    },
                    child: Text(
                      "저 장 하 기",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


