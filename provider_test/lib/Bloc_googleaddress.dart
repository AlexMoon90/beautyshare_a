import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/distant_google.dart';
import 'package:rxdart/rxdart.dart';


class Bloc_googleaddress {

  var address = GoogleGeocoding('AIzaSyDPQQKVeBdg--6A5n0J_7LMOH2PzpzY_j8', language: 'ko' );

  BehaviorSubject adress_behavoir=BehaviorSubject();
  Observable get adress_observer => adress_behavoir.stream;

  Future search_address (Coordinates query) async {
    var addresses = await address.findAddressesFromCoordinates(query);

    Address addrr = addresses[0];
    List a =[];
    a=addrr.addressLine.split(" ");
    print(a.toString());
    String textad;
    if(addrr.locality==null) textad= a[2]+' '+a[3];
    else if(addrr.locality!=null) textad=a[2]+' '+a[3]+' '+a[4]??null;

   adress_behavoir.sink.add(textad);
  }

}