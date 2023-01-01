import 'package:mwinkhouse2/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse2/objbox/models/Contatto.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';
import 'package:objectbox/objectbox.dart';

import 'Agente.dart';
import 'Appuntamento.dart';

@Entity()
class Anagrafica{

  @Id()
  int? codAnagrafica;

  String? nome;
  String? cognome;
  String? ragioneSociale;
  String? indirizzo;
  String? provincia;
  String? cap;
  String? citta;

  @Property(type: PropertyType.date)
  DateTime? dataInserimento;

  String? commento;
  bool? storico;
  final classeCliente = ToOne<ClasseCliente>();
  final agenteInseritore = ToOne<Agente>();
  String? codiceFiscale;
  String? partitaIva;
  final contatti = ToMany<Contatto>();
  final immobiliAbbinati = ToMany<Immobile>();
  final appuntamenti = ToMany<Appuntamento>();
  final proprieta = ToMany<Immobile>();

}

