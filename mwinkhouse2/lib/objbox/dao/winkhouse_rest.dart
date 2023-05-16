import 'dart:convert';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';

import '../models/CriteriRicercaImmobile.dart';
import 'package:http/http.dart' as http;

import '../models/CriterioRicercaRest.dart';

class WinkhouseRest{

  static String SEARCH_TYPE_IMMOBILE = 'SEARCH_IMMOBILI';
  static String COLUMN_CITTA_IMMOBILE = 'CITTA';
  static String COLUMN_PROVINCIA_IMMOBILE = 'PROVINCIA';
  static String COLUMN_CAP_IMMOBILE = 'CAP';
  static String COLUMN_ZONA_IMMOBILE = 'ZONA';
  static String COLUMN_INDIRIZZO_IMMOBILE = 'INDIRIZZO';

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

  List<CriterioRicercaRest> buildBodyObj({criteri:CriteriRicercaImmobile}){
    List<CriterioRicercaRest> criteriRicerca = List<CriterioRicercaRest>.empty(growable: true);
    if (criteri.citta != ''){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_CITTA_IMMOBILE,
          valueDa: criteri.citta);
      criteriRicerca.add(crr);
    }
    if (criteri.provincia != ''){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_PROVINCIA_IMMOBILE,
          valueDa: criteri.provincia);
      criteriRicerca.add(crr);
    }
    if (criteri.zona != ''){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_ZONA_IMMOBILE,
          valueDa: criteri.zona);
      criteriRicerca.add(crr);
    }
    if (criteri.indirizzo != ''){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_INDIRIZZO_IMMOBILE,
          valueDa: criteri.indirizzo);
      criteriRicerca.add(crr);
    }
    if (criteri.cap != ''){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_CAP_IMMOBILE,
          valueDa: criteri.cap);
      criteriRicerca.add(crr);
    }

    return criteriRicerca;
  }

  Stream<List<Immobile>> findImmobili({criteri:CriteriRicercaImmobile}) async*{
    List<Immobile> immobili = List<Immobile>.empty(growable: true);
    Uri findUrl = Uri.parse("${this.getWinkhouseIp()}/search");

      List<CriterioRicercaRest> criteriRicerca = buildBodyObj(criteri: criteri);
      for(var i=0;i<criteriRicerca.length;i++){
        final response = await http.post(
            findUrl,
            headers:getHeaders(),
            body: jsonEncode(criteriRicerca[i])
        );
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          Iterable l = json.decode(response.body);
          immobili.addAll(List<Immobile>.from(l.map((model)=> Immobile.fromJson(model))));

          yield immobili;
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Errore caricamento immobili');
        }

      }

      yield immobili;
  }

}