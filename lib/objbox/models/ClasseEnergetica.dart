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

  int getCodice(){
    return codClasseEnergetica ?? 0;
  }

  String getNome(){
    return nome ?? '';
  }

  String getDescrizione(){
    return descrizione ?? '';
  }

  int getOrdine(){
    return ordine ?? 0;
  }
}