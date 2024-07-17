import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaImmobile{

  TipologiaImmobile():super();

  @Id()
  int? codTipologiaImmobile;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is TipologiaImmobile && codTipologiaImmobile == other.codTipologiaImmobile;


  factory TipologiaImmobile.fromJson(Map<String, dynamic> json){
    TipologiaImmobile instance = TipologiaImmobile();
    instance.codTipologiaImmobile = json['codTipologiaImmobile'];
    instance.descrizione = json['descrizione'];
      return instance;
  }
}