import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/objbox/models/TipologiaAppuntamento.dart';
import 'package:objectbox/objectbox.dart';

import 'Agente.dart';

@Entity()
class Appuntamento{
  @Id()
  int? codAppuntamento ;
  @Property(type: PropertyType.date)
  DateTime? dataInserimento ;
  @Property(type: PropertyType.date)
  DateTime? dataAppuntamento ;
  @Property(type: PropertyType.date)
  DateTime? dataFineAppuntamento ;
  final tipologiaAppuntamento = ToOne<TipologiaAppuntamento>();
  String? iCalUID ;
  String? descrizione ;
  String? luogo ;
  final agentiAppuntamento = ToMany<Agente>();
  final anagraficheAppuntamento = ToMany<Anagrafica>();
}