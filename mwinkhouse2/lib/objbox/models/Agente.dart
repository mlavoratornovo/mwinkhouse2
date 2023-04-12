import 'package:objectbox/objectbox.dart';

import 'Contatto.dart';

@Entity()
class Agente {
  Agente():super();
  @Id()
  int? codAgente;
  String? nome;
  String? cognome;
  String? indirizzo;
  String? provincia;
  String? cap;
  String? citta;
  final contatti = ToMany<Contatto>();

  factory Agente.fromJson(Map<String, dynamic> json){
    Agente instance = Agente();
    instance.codAgente = json['codClasseCliente'];
    instance.nome = json['descrizione'];
    instance.cognome = json['ordine'];
    instance.indirizzo = json['indirizzo'];
    instance.provincia = json['provincia'];
    instance.cap = json['cap'];
    instance.citta = json['citta'];
   // instance.contatti = ToMany<Contatto>();

    return instance;
  }
}