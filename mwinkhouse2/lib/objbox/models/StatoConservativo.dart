import 'package:objectbox/objectbox.dart';

@Entity()
class StatoConservativo{

  StatoConservativo():super();

  @Id()
  int? codStatoConservativo;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is StatoConservativo && codStatoConservativo == other.codStatoConservativo;


  factory StatoConservativo.fromJson(Map<String, dynamic> json){
    StatoConservativo instance = StatoConservativo();
    instance.codStatoConservativo = json['codStatoConservativo'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}