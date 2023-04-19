import 'dart:io';

import 'package:mwinkhouse2/objbox/models/Agente.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaColloquio.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';
import 'Anagrafica.dart';
import 'Immobile.dart';

@Entity()
class Colloquio{

  Colloquio():super();
  @Id()
  int? codColloquio;

  String? descrizione ;
  final agenteInseritore = ToOne<Agente>();
  final immobileAbbinato = ToOne<Immobile>();
  final tipologiaColloquio = ToOne<TipologiaColloquio>();

  final anagrafiche = ToMany<Anagrafica>();

  @Property(type: PropertyType.date)
  DateTime? dataInserimento;

  @Property(type: PropertyType.date)
  DateTime? dataColloquio;

  String? luogoIncontro ;
  bool? scadenziere ;
  String? commentoAgenzia ;
  String? commentoCliente ;
  int? codParent ;
  String? iCalUid ;

  factory Colloquio.fromJson(Map<String, dynamic> json){
    Colloquio instance = Colloquio();
    instance.codColloquio = json['codColloquio'];
    instance.descrizione = json['descrizione'];
    instance.immobileAbbinato.target = Immobile.fromJson(json['immobileAbbinato']);
    instance.tipologiaColloquio.target = new TipologiaColloquio();
    instance.tipologiaColloquio.target?.codTipologiaColloquio = json['codTipologiaColloquio'];
    instance.dataInserimento = new DateFormat("MMM d, yyyy hh:mm:ss").parse(json['dataInserimento']);
    instance.dataColloquio = new DateFormat("MMM d, yyyy hh:mm:ss").parse(json['dataColloquio']);
    instance.luogoIncontro = json['luogoIncontro'];
    instance.scadenziere = json['scadenziere'];
    instance.commentoAgenzia = json['commentoAgenzia'];
    instance.commentoCliente = json['commentoCliente'];
    instance.iCalUid = json['iCalUid'];
    return instance;
  }
}