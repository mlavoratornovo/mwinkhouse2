import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaContatto{

  TipologiaContatto():super();

  @Id()
  int? codTipologiaContatto;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaContatto && this.codTipologiaContatto == other.codTipologiaContatto;

  @override
  int get hashCode => super.hashCode;

  factory TipologiaContatto.fromJson(Map<String, dynamic> json){
    TipologiaContatto instance = TipologiaContatto();
    instance.codTipologiaContatto = json['codTipologiaContatto'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}