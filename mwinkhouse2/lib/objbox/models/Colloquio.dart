import 'package:mwinkhouse2/objbox/models/Agente.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaColloquio.dart';
import 'package:objectbox/objectbox.dart';

import 'Anagrafica.dart';
import 'Immobile.dart';

@Entity()
class Colloquio{
  @Id()
  int? codColloquio;

  String? descrizione ;
  final agenteInseritore = ToOne<Agente>();
  final immobileAbbinato = ToOne<Immobile>();
  final tipologiaColloquio = ToOne<TipologiaColloquio>();
  final anagraficheColloquio = ToMany<Anagrafica>();

  @Property(type: PropertyType.date)
  DateTime? dataInserimento ;

  @Property(type: PropertyType.date)
  DateTime? dataColloquio ;

  String? luogoIncontro ;
  bool? scadenziere ;
  String? commentoAgenzia ;
  String? commentoCliente ;
  int? codParent ;
  String? iCalUid ;

}