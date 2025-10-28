import 'ClasseCliente.dart';
import 'Colloquio.dart';
import 'Contatto.dart';
import 'Immobile.dart';
import 'package:objectbox/objectbox.dart';
import 'package:intl/intl.dart';
import 'Agente.dart';
import 'Appuntamento.dart';

@Entity()
class Anagrafica{

  Anagrafica():super();
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
  @Backlink('proprietari')
  final proprieta = ToMany<Immobile>();
  @Backlink('anagrafiche')
  final colloqui = ToMany<Colloquio>();

  factory Anagrafica.fromJson(Map<String, dynamic> json){
    Anagrafica instance = Anagrafica();
    instance.codAnagrafica = json['codAnagrafica'];
    instance.nome = json['nome'];
    instance.cognome = json['cognome'];
    instance.ragioneSociale= json['ragioneSociale'];
    instance.indirizzo = json['indirizzo']??'' ' ' + json['ncivico']??'';
    instance.provincia = json['provincia'];
    instance.cap = json['cap'];
    instance.citta = json['citta'];
    instance.dataInserimento = DateFormat("MMM d, yyyy hh:mm:ss").parse(json['dataInserimento']);
    instance.commento = json['commento'];
    instance.storico = json['storico'];
    instance.codiceFiscale = json['codiceFiscale'];
    instance.partitaIva = json['nome'];
    instance.classeCliente.target = (json['classeCliente']!=null)?ClasseCliente.fromJson(json['classeCliente']):null;
    // instance.agenteInseritore = ToOne<Agente>();
    if (json['contatti'] != null){
      instance.contatti.addAll(List<Contatto>.from(json['contatti'].map((model)=> Contatto.fromJson(model))));
    }
    // instance.immobiliAbbinati = ToMany<Immobile>();
    // instance.appuntamenti = ToMany<Appuntamento>();
    if (json['immobili'] != null){
      instance.proprieta.addAll(List<Immobile>.from(json['immobili'].map((model)=> Immobile.fromJson(model))));
    }
    if (json['colloqui'] != null){
      instance.colloqui.addAll(List<Colloquio>.from(json['colloqui'].map((model)=> Colloquio.fromJson(model))));
    }
    return instance;
  }

}

