import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaColloquio{

  TipologiaColloquio():super();

  @Id()
  int? codTipologiaColloquio;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaColloquio && this.codTipologiaColloquio == other.codTipologiaColloquio;

  @override
  int get hashCode => super.hashCode;

  factory TipologiaColloquio.fromJson(Map<String, dynamic> json){
    TipologiaColloquio instance = TipologiaColloquio();
    instance.codTipologiaColloquio = json['codTipologiaColloquio'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}