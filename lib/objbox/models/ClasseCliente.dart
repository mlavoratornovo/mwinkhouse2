import 'package:mwinkhouse/objbox/models/IDatiBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseCliente implements IDatiBase{
  ClasseCliente():super();
  @Id()
  int? codClasseCliente;

  String? descrizione;

  int? ordine;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is ClasseCliente && codClasseCliente == other.codClasseCliente;


  factory ClasseCliente.fromJson(Map<String, dynamic> json){
    ClasseCliente instance = ClasseCliente();
    instance.codClasseCliente = json['codClasseCliente'];
    instance.descrizione = json['descrizione'];
    instance.ordine = json['ordine'];
    return instance;
  }

  int getCodice(){
    return codClasseCliente ?? 0;
  }

  String getNome(){
    return '';
  }

  String getDescrizione(){
    return descrizione ?? '';
  }

  int getOrdine(){
    return ordine ?? 0;
  }

}