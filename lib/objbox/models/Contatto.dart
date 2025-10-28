import 'TipologiaContatto.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contatto{
  Contatto():super();
  @Id()
  int? codContatto;
  String? contatto;
  String? descrizione;
  int? codTipologiaContatto;
  int? codAnagrafica;
  int? codAgente;
  final tipologiaContatto = ToOne<TipologiaContatto>();

  factory Contatto.fromJson(Map<String, dynamic> json){
    Contatto instance = Contatto();
    instance.codContatto = json['codClasseCliente'];
    instance.descrizione = json['descrizione'];
    instance.contatto = json['contatto'];
    return instance;
  }
}