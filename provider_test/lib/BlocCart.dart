import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:random_color/random_color.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:faker/faker.dart';

class Bloc_color {

  List<Color> _collist = [];
  Color color;

  BehaviorSubject<List<Color>> coloradd = BehaviorSubject();
  Observable<List<Color>> get colobserve => coloradd.stream;

  BehaviorSubject buttonadd= BehaviorSubject();
  Observable get buttonobserve => buttonadd.stream;

  BehaviorSubject colorchange = BehaviorSubject();
  Observable get color_observe => colorchange.stream;

  void buttonchange(int index){

    buttonadd.sink.add(index);
  }

   void color_change (Color color) {

    colorchange.sink.add(color);
   }


  void makewidgetlist() {
    RandomColor CC = RandomColor();
    Color colors = CC.randomColor();
    _collist.insert(0, colors);

    coloradd.sink.add(_collist);
  }

  void deletelist(){
    _collist.removeLast();
    coloradd.sink.add(_collist);

  }

void disclose() {
    coloradd.close();

}

}

class Bloc_cart {
  List<Map> cartlist = [];

  BehaviorSubject cartadd  = BehaviorSubject();
  Observable get cartobserve => cartadd.stream;

   void coloraddcart(Color color) {
     var colormap = Map();
     bool i= true ;
     colormap['Class']=i;
     colormap['Color']=color;

     cartlist.add(colormap);
    cartadd.sink.add(cartlist);
  }

  void avaraddcart(Avataaar avar, String name) {

    var colormap = Map();
    bool i= false ;
    colormap['Class']=i;
    colormap['Avar']=avar;
    colormap['Name']=name;

    cartlist.add(colormap);
    cartadd.sink.add(cartlist);
  }

  void delcart(int index) {
    cartlist.removeAt(index);
    cartadd.sink.add(cartlist);
  }

  void disclose() {
     cartadd.close();
  }

}


class Bloc_avatar {

  List<Map> avarlist = [];
  List<Map> avarlistrever=[];

  BehaviorSubject avatarsub = BehaviorSubject();
  Observable get avarobserve => avatarsub.stream;

  void makeAvatar() {
    Avataaar avar;
    String name;
    var avarmap = Map();
    avar = Avataaar.random();
    name = faker.person.name();
    avarmap['avartar'] = avar;
    avarmap['name']=name;
    //avarlist.add(avarmap);
    avarlist.insert(0, avarmap);
    avarlistrever = avarlist.reversed.toList();

    avatarsub.sink.add(avarlist);
  }

  void delAvatar() {
    avarlist.removeLast();
    avatarsub.sink.add(avarlist);
  }

  void disclose() {
    avatarsub.close();

  }

}
