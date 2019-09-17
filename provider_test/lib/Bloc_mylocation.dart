
import 'package:rxdart/rxdart.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/distant_google.dart';

class Bloc_mylocation {
   Coordinates  mylocation;
  var curren_location ;


  Future getcurrent () async {
    var loca =  Location().onLocationChanged().listen((a){
      mylocation = Coordinates(a['latitude'], a['longitude']);
    });

  }

  Future getfirst()    async {

    var loca = await Location().getLocation();

    mylocation = Coordinates( loca['latitude'], loca['longitude']);

  }

}