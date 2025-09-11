import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse/objbox/models/Comune.dart';
import 'package:mwinkhouse/objbox/models/Immobile.dart';
import 'package:mwinkhouse/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse/objbox/models/TipologiaContatto.dart';
import 'package:mwinkhouse/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse/objbox/models/TipologiaStanza.dart';

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
  static String COLUMN_CODRISCALDAMENTO = 'CODRISCALDAMENTO';
  static String COLUMN_CODSTATO = 'CODSTATO';
  static String COLUMN_CODTIPOLOGIA = 'CODTIPOLOGIA';
  static String COLUMN_CODCLASSEENERGETICA = 'CODCLASSEENERGETICA';
  List<Comune> comuni = List<Comune>.empty(growable: true);

  String? getWinkhouseIp(){
    return Settings.getValue<String>("ipWinkhouse", defaultValue: "http://127.0.0.1");
  }

  String? getWinkhousePort(){
    return Settings.getValue<String>("portWinkhouse", defaultValue: "81");
  }

  Map<String,String> getHeaders(){
    Map<String,String> retval = <String,String>{};
    retval['Content-Type'] = 'application/json';
    return retval;
  }

  List<CriterioRicercaRest> buildBodyObj({criteri =CriteriRicercaImmobile}){
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
    if (criteri.riscaldamento != null){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_CODRISCALDAMENTO,
          valueDa: criteri.riscaldamento.codRiscaldamento.toString());
      criteriRicerca.add(crr);
    }
    if (criteri.statoConservativo != null){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_CODSTATO,
          valueDa: criteri.statoConservativo.codStatoConservativo.toString());
      criteriRicerca.add(crr);
    }
    if (criteri.tipologiaImmobile != null){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: COLUMN_CODRISCALDAMENTO,
          valueDa: criteri.tipologiaImmobile.codTipologiaImmobile.toString());
      criteriRicerca.add(crr);
    }
    if (criteri.classeEnergetica != null){
      CriterioRicercaRest crr = CriterioRicercaRest(
          searchType: SEARCH_TYPE_IMMOBILE,
          columnName: WinkhouseRest.COLUMN_CODCLASSEENERGETICA,
          valueDa: criteri.classeEnergetica.codClasseEnergetica.toString());
      criteriRicerca.add(crr);
    }

    return criteriRicerca;
  }

  Stream<List<Immobile>> findImmobili({criteri =CriteriRicercaImmobile,tipologieImmobili =Map<int,TipologiaImmobile>}) async*{
    //List<Immobile> immobili = List<Immobile>.empty(growable: true);
    Map<int,Immobile> mimmobili = <int,Immobile>{};
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/search");

      List<CriterioRicercaRest> criteriRicerca = buildBodyObj(criteri: criteri);
      for(var i=0;i<criteriRicerca.length;i++){
        final response = await http.post(
            findUrl,
            headers:getHeaders(),
            body: jsonEncode([criteriRicerca[i]])
        );
        if (response.statusCode == 200) {
          Iterable l = json.decode(response.body);
          List<Immobile> list = List<Immobile>.from(l.map((model)=> Immobile.fromJson(model)));
          for(final e in list){
            mimmobili[e.codImmobile??0] = e;
            e.tipologiaImmobile.target = tipologieImmobili[e.codImmobile??0];
            var currentElement = e;
          }
          yield mimmobili.values.toList();
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('code:${response.statusCode} message:${response.body}');
        }

      }

      yield mimmobili.values.toList();
  }

  Future<List<TipologiaImmobile>> getTipologieImmobili() async{
    List<TipologiaImmobile> tipologieImmobili = List<TipologiaImmobile>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=ti");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      tipologieImmobili.addAll(List<TipologiaImmobile>.from(l.map((model)=> TipologiaImmobile.fromJson(model))));
      return tipologieImmobili;
    } else {
      throw Exception('Errore caricamento tipologie immobili');
    }
  }

  Future<List<StatoConservativo>> getStatoConservativo() async {
    List<StatoConservativo> statoConservativo = List<StatoConservativo>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=sc");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      statoConservativo.addAll(List<StatoConservativo>.from(l.map((model)=> StatoConservativo.fromJson(model))));
      return statoConservativo;
    } else {
      throw Exception('Errore caricamento stati conservativi');
    }
  }

  Future<List<Riscaldamento>> getRiscaldamento() async {
    List<Riscaldamento> riscaldamento = List<Riscaldamento>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=ri");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      riscaldamento.addAll(List<Riscaldamento>.from(l.map((model)=> Riscaldamento.fromJson(model))));
      return riscaldamento;
    } else {
      throw Exception('Errore caricamento riscaldamenti');
    }
  }

  Future<List<ClasseEnergetica>> getClasseEnergetica() async {
    List<ClasseEnergetica> classeEnergetica = List<ClasseEnergetica>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=ce");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      classeEnergetica.addAll(List<ClasseEnergetica>.from(l.map((model)=> ClasseEnergetica.fromJson(model))));
      return classeEnergetica;
    } else {
      throw Exception('Errore caricamento classi energetiche');
    }
  }

  Future<List<TipologiaStanza>> getTipologiaStanza() async {
    List<TipologiaStanza> tipologiaStanza = List<TipologiaStanza>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=ts");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      tipologiaStanza.addAll(List<TipologiaStanza>.from(l.map((model)=> TipologiaStanza.fromJson(model))));
      return tipologiaStanza;
    } else {
      throw Exception('Errore caricamento classi energetiche');
    }
  }

  Future<List<TipologiaContatto>> getTipologiaContatto() async {
    List<TipologiaContatto> tipologiaContatto = List<TipologiaContatto>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=tcon");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      tipologiaContatto.addAll(List<TipologiaContatto>.from(l.map((model)=> TipologiaContatto.fromJson(model))));
      return tipologiaContatto;
    } else {
      throw Exception('Errore caricamento classi energetiche');
    }
  }

  Future<List<ClasseCliente>> getClassiClienti() async {
    List<ClasseCliente> classeCliente = List<ClasseCliente>.empty(growable: true);
    Uri findUrl = Uri.parse("${getWinkhouseIp()}:${getWinkhousePort()}/core/search?tipo=cc");
    final response = await http.get(findUrl, headers:getHeaders());
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      classeCliente.addAll(List<ClasseCliente>.from(l.map((model)=> ClasseCliente.fromJson(model))));
      return classeCliente;
    } else {
      throw Exception('Errore caricamento classi clienti');
    }
  }

  Stream<List<Comune>> findComuni(String nomeComune) async*{

    if (comuni.isEmpty){
      this.comuni = await loadJsonFile("assets/comuni.json");
    }
    var comuniFind = this.comuni.where((comune)=>comune.comune.toString().contains(nomeComune));
    yield comuniFind.toList();
  }

  Future<List<Comune>> loadJsonFile(String path) async {
    final contents = await rootBundle.loadString(path);
    Iterable jsonList = json.decode(contents);
    List<Comune> comuni = List<Comune>.empty(growable: true);
    comuni.addAll(List<Comune>.from(jsonList.map((model)=> Comune.fromJson(model))));
    return comuni;
  }

}