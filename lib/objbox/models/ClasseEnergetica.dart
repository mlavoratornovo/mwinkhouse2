import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class ClasseEnergetica implements IDatiBase{

  ClasseEnergetica():super();

  @Id()
  int? codClasseEnergetica;

  String? nome;

  String? descrizione;

  int? ordine;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is ClasseEnergetica && codClasseEnergetica == other.codClasseEnergetica;


  factory ClasseEnergetica.fromJson(Map<String, dynamic> json){
    ClasseEnergetica instance = ClasseEnergetica();
    instance.codClasseEnergetica = json['codClasseEnergetica'];
    instance.descrizione = json['descrizione'];
    instance.nome = json['nome'];
    instance.ordine = json['ordine'];
    return instance;
  }

  @override
  int getCodice(){
    return codClasseEnergetica ?? 0;
  }

  @override
  String getNome(){
    return nome ?? '';
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
  void setCodice(int codice) {
    codClasseEnergetica = codice;
  }

  @override
  void setDescrizione(String descrizione) {
    this.descrizione = descrizione;
  }

  @override
  void setNome(String nome) {
    this.nome = nome;
  }

  @override
  void setOrdine(int ordine) {
    this.ordine = ordine;
  }
}