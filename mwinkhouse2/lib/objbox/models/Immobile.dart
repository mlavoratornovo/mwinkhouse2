import 'dart:ffi';

import 'package:mwinkhouse/objbox/models/Agente.dart';
import 'package:mwinkhouse/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse/objbox/models/Immagine.dart';
import 'package:mwinkhouse/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse/objbox/models/TipologiaImmobile.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';
import 'Anagrafica.dart';
import 'Colloquio.dart';

@Entity()
class Immobile{

  Immobile():super();

  @Id()
  int? codImmobile;
  String? rif;
  String? indirizzo;
  String? provincia;
  String? cap;
  String? citta;
  String? zona;

  @Property(type: PropertyType.date)
  DateTime? dataInserimento;

  @Property(type: PropertyType.date)
  DateTime? dataLibero;
  
  String? descrizione;
  String? mutuoDescrizione;
  double? prezzo;
  double? mutuo;
  double? spese;
  String? varie;
  bool? visione;
  bool? storico;
  bool? affittabile;
  int? mq;
  int? annoCostruzione;
  final agenteInseritore = ToOne<Agente>();
  final riscaldamento = ToOne<Riscaldamento>();
  final statoConservativo = ToOne<StatoConservativo>();
  final tipologiaImmobile = ToOne<TipologiaImmobile>();
  final classeEnergetica = ToOne<ClasseEnergetica>();
  final stanze = ToMany<StanzaImmobile>();
  @Backlink()
  final colloqui = ToMany<Colloquio>();
  final immagini = ToMany<Immagine>();
  final proprietari = ToMany<Anagrafica>();

  factory Immobile.fromJson(Map<String, dynamic> json){

    Immobile instance = Immobile();

    instance.rif = json['rif'];
    instance.codImmobile = json['codImmobile'];
    instance.indirizzo = json['indirizzo'];
    instance.provincia = json['provincia'];
    instance.cap = json['cap'];
    instance.citta = json['citta'];
    instance.zona = json['zona'];
    instance.dataInserimento = new DateFormat("MMM d, yyyy hh:mm:ss").parse(json['dataInserimento']);
    instance.dataLibero = new DateFormat("MMM d, yyyy hh:mm:ss").parse(json['dataLibero']);
    instance.descrizione = json['descrizione'];
    instance.mutuoDescrizione = json['mutuoDescrizione'];
    instance.prezzo = json['prezzo'].toDouble();
    instance.mutuo = json['mutuo'].toDouble();
    instance.spese = json['spese'].toDouble();
    instance.varie = json['varie'];
    instance.visione = json['visione'];
    instance.storico = json['storico'];
    instance.affittabile = json['affittabile'];
    instance.mq = json['mq'];
    instance.annoCostruzione = json['annoCostruzione'];
    instance.riscaldamento.target = Riscaldamento.fromJson(json['riscaldamento']);
    instance.statoConservativo.target = StatoConservativo.fromJson(json['statoConservativo']);
    instance.tipologiaImmobile.target = TipologiaImmobile.fromJson((json['tipologiaImmobile']!= null)?json['tipologiaImmobile']:json);
    instance.classeEnergetica.target = ClasseEnergetica.fromJson(json['classeEnergetica']);
    if (json['stanze'] != null){
      instance.stanze.addAll(List<StanzaImmobile>.from(json['stanze'].map((model)=> StanzaImmobile.fromJson(model))));
    }
    if (json['colloqui'] != null){
      instance.colloqui.addAll(List<Colloquio>.from(json['colloqui'].map((model)=> Colloquio.fromJson(model))));
    }
    if (json['anagrafichePropietarie'] != null){
      instance.proprietari.addAll(List<Anagrafica>.from(json['anagrafichePropietarie'].map((model)=> Anagrafica.fromJson(model))));
    }

    return instance;
  }
}