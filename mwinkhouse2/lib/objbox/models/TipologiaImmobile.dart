import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaImmobile{

  TipologiaImmobile():super();

  @Id()
  int? codTipologiaImmobile;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaImmobile && this.codTipologiaImmobile == other.codTipologiaImmobile;

  @override
  int get hashCode => super.hashCode;

  factory TipologiaImmobile.fromJson(Map<String, dynamic> json){
    TipologiaImmobile instance = TipologiaImmobile();
    if (json != null){
      instance.codTipologiaImmobile = json['codTipologiaImmobile'];
      instance.descrizione = json['descrizione'];
    }
    return instance;
  }
}