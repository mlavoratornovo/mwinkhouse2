import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaStanza{

  TipologiaStanza():super();
  @Id()
  int? codTipologiaStanza;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaStanza && this.codTipologiaStanza == other.codTipologiaStanza;

  @override
  int get hashCode => super.hashCode;

  factory TipologiaStanza.fromJson(Map<String, dynamic> json){
    TipologiaStanza instance = TipologiaStanza();
    instance.codTipologiaStanza = json['codTipologiaStanza'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}