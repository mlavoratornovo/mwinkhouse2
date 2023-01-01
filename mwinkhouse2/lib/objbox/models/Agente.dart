import 'package:objectbox/objectbox.dart';

import 'Contatto.dart';

@Entity()
class Agente {

  @Id()
  int? codAgente;
  String? nome;
  String? cognome;
  String? indirizzo;
  String? provincia;
  String? cap;
  String? citta;
  final contatti = ToMany<Contatto>();
}