import 'package:objectbox/objectbox.dart';

@Entity()
class StatoConservativo{

  StatoConservativo():super();

  @Id()
  int? codStatoConservativo;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is StatoConservativo && this.codStatoConservativo == other.codStatoConservativo;

  @override
  int get hashCode => super.hashCode;

  factory StatoConservativo.fromJson(Map<String, dynamic> json){
    StatoConservativo instance = StatoConservativo();
    instance.codStatoConservativo = json['codStatoConservativo'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}