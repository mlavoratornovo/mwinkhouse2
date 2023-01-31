import 'dart:ffi';

import 'package:mwinkhouse2/objbox/models/Agente.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Immagine.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:objectbox/objectbox.dart';

import 'Anagrafica.dart';
import 'Colloquio.dart';

@Entity()
class Immobile{

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
}