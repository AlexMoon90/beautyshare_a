import 'package:flutter/material.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:rxdart/rxdart.dart';

class Bloc_avatar {
  Avataaar avar;
  List<Avataaar> avarlist = [];

  BehaviorSubject avatarsub = BehaviorSubject();
  Observable get avarobserve => avatarsub.stream;

  void makeAvatar() {
    avar = Avataaar.random();
    avarlist.add(avar);
    avatarsub.sink.add(avarlist);
  }

  void delAvatar() {
    avarlist.removeLast();
    avatarsub.sink.add(avarlist);
  }
}
