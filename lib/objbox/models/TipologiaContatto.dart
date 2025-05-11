import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaContatto{

  TipologiaContatto():super();

  @Id()
  int? codTipologiaContatto;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is TipologiaContatto && codTipologiaContatto == other.codTipologiaContatto;


  factory TipologiaContatto.fromJson(Map<String, dynamic> json){
    TipologiaContatto instance = TipologiaContatto();
    instance.codTipologiaContatto = json['codTipologiaContatto'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}