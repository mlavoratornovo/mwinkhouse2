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

  @override
  int getCodice(){
    return codClasseCliente ?? 0;
  }

  @override
  String getNome(){
    return '';
  }

  @override
  String getDescrizione(){
    return descrizione ?? '';
  }

  @override
  int getOrdine(){
    return ordine ?? 0;
  }

  @override
  void setCodice(int codice){
    codClasseCliente = codice;
  }

  @override
  void setNome(String nome){
    // TODO: implement setNome
  }

  @override
  void setDescrizione(String descrizione){
    this.descrizione = descrizione;
  }

  @override
  void setOrdine(int ordine){
    this.ordine = ordine;
  }

}