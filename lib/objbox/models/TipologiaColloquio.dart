import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaColloquio{

  TipologiaColloquio():super();

  @Id()
  int? codTipologiaColloquio;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is TipologiaColloquio && codTipologiaColloquio == other.codTipologiaColloquio;


  factory TipologiaColloquio.fromJson(Map<String, dynamic> json){
    TipologiaColloquio instance = TipologiaColloquio();
    instance.codTipologiaColloquio = json['codTipologiaColloquio'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}