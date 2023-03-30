import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';

import '../models/CriteriRicercaImmobile.dart';
import 'package:http/http.dart' as http;

class WinkhouseRest{

  String getWinkhouseIp(){
    return Settings.getValue<String>("ipWinkhouse", "127.0.0.1");
  }

  String getWinkhousePort(){
    return Settings.getValue<String>("portWinkhouse", "81");
  }

  Map<String,String> getHeaders(){
    Map<String,String> retval = Map<String,String>();
    retval['Content-Type'] = 'application/json';
    return retval;
  }

  Stream<List<Immobile>> findImmobili({criteri:CriteriRicercaImmobile}) async*{

      Uri findUrl = Uri.parse("http://${this.getWinkhouseIp()}");
          // :${this.getWinkhousePort()}/search");

      final response = await http.post(findUrl,headers:this.getHeaders());
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Iterable l = json.decode(response.body);
        List<Immobile> immobili = List<Immobile>.from(l.map((model)=> Immobile.fromJson(model)));
        yield immobili;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Errore caricamento immobili');
      }
  }

}