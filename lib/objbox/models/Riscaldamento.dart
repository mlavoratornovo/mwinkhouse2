import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class Riscaldamento implements IDatiBase{

  Riscaldamento():super();

  @Id()
  int? codRiscaldamento;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is Riscaldamento && codRiscaldamento == other.codRiscaldamento;


  factory Riscaldamento.fromJson(Map<String, dynamic> json){
    Riscaldamento instance = Riscaldamento();
    instance.codRiscaldamento = json['codRiscaldamento'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

  int getCodice(){
    return codRiscaldamento ?? 0;
  }

  String getNome(){
    return '';
  }

  String getDescrizione(){
    return descrizione ?? '';
  }

  int getOrdine(){
    return 0;
  }
}