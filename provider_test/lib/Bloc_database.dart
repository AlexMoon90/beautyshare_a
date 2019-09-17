import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:math';


double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  if (lat2 != null || lon2 != null) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  return 0.0;
}


class Bloc_database {
  Database mydatabase;
  List<Map<String, dynamic>> dbadd = [];
  String photourl =
      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=";
  String kGoogleApiKey = "AIzaSyDPQQKVeBdg--6A5n0J_7LMOH2PzpzY_j8";

  BehaviorSubject shop_behave = BehaviorSubject();
  Observable get shop_observe => shop_behave.stream;

  Future<List> Get(Coordinates current, [String menu_distance ]) async {
    var result = await mydatabase.query("Shop",
        columns: ["id", "name", "phone", "address", "photo", "long", "lat"]);

    List<Map<String, dynamic >> sortdb =[];
    if (result != null) {

      /* 1km 반경내 정보 필터링 */
      dbadd = List<Map<String, dynamic>>.from(result);

    switch(menu_distance) {
    case "1.5 km": {
    dbadd.retainWhere((a) => (
    a['lat'] < current.latitude + 0.00909438*1.5 &&
    a['lat'] > current.latitude - 0.00909438*1.5 &&
    a['long'] < current.longitude + 0.011268875*1.5 &&
    a['long'] > current.longitude - 0.011268875*1.5
    ));
    }
    break;

    case "3 km": {
    dbadd.retainWhere((a) => (
    a['lat'] < current.latitude + 0.00909438*3 &&
    a['lat'] > current.latitude - 0.00909438*3 &&
    a['long'] < current.longitude + 0.011268875*3 &&
    a['long'] > current.longitude - 0.011268875*3
    ));
    }
    break;

    case "5 km": {
    dbadd.retainWhere((a) => (
    a['lat'] < current.latitude + 0.00909438*5 &&
    a['lat'] > current.latitude - 0.00909438*5 &&
    a['long'] < current.longitude + 0.011268875*5 &&
    a['long'] > current.longitude - 0.011268875*5
    ));

    }
    break;

    case "10 km": {
    dbadd.retainWhere((a) => (
    a['lat'] < current.latitude + 0.00909438*10 &&
    a['lat'] > current.latitude - 0.00909438*10 &&
    a['long'] < current.longitude + 0.011268875*10 &&
    a['long'] > current.longitude - 0.011268875*10
    ));

    }
    break;

    default: {
    dbadd.retainWhere((a) => (
    a['lat'] < current.latitude + 0.00909438*10 &&
    a['lat'] > current.latitude - 0.00909438*10 &&
    a['long'] < current.longitude + 0.011268875*10 &&
    a['long'] > current.longitude - 0.011268875*10
    ));

    }
    break;
    }


      dbadd.map((a) {
        var b = Map<String, dynamic>.from(a);
        var dis = calculateDistance(
        current.latitude, current.longitude, a['lat'], a['long']);


        Map<String, dynamic> c = {"dis": dis};
        b.addAll(c);
        sortdb.add(b);
      }).toList();
     sortdb.sort((a, b) => a['dis'].compareTo(b['dis'])); }

     var model = Model_shopinfor();

     var Model_sortdb = sortdb.map((a) => Model_shopinfor.fromJson(a)).toList();

    shop_behave.sink.add(Model_sortdb);

    return Model_sortdb;

  }



  Create() async {
    var mypath = await getDatabasesPath();

    mydatabase = await openDatabase(join(mypath, 'mydb.db'), version: 1,
        onCreate: (db, version) {
      return db.execute(
          " CREATE TABLE IF NOT EXISTS Shop (id TEXT PRIMARY KEY, name TEXT, phone TEXT, address TEXT, photo TEXT, long REAL, lat REAL)");
    });
  }

  Future<int> Add(Model_shopinfor shopinfor) async {
    var result = await mydatabase.insert("Shop", shopinfor.toMap());
    return result;
  }

  Future<int> Delete(String id) async {
    await mydatabase.delete("Shop", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> Update(Model_shopinfor shopinfor) async {
    await mydatabase.update("Shop", shopinfor.toMap(),
        where: "id = ?", whereArgs: [shopinfor.id]);
  }

  Future <bool> Query (Model_shopinfor shopinfor) async {
   var result = await mydatabase.query("Shop", where : 'id = ?', whereArgs: [shopinfor.id]);
    if(result.length == null || result.length ==0) {return true;}
    else if(result.length !=0) {return false;}
  }


}

class Model_shopinfor {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String photo;
  final double long;
  final double lat;
  final double dis;

  Model_shopinfor(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.photo,
      this.long ,
      this.lat,
       this.dis

      });

  Model_shopinfor.fromJson(Map data)
      : id = data["id"],
        name = data["name"],
        phone = data["phone"],
        address = data["address"],
        photo = data["photo"],
        long = data["long"],
        lat = data["lat"],
        dis = data["dis"];

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "photo": photo,
        "long": long,
        "lat": lat
      };
}
