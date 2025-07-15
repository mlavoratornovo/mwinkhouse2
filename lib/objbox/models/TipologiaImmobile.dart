import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class TipologiaImmobile implements IDatiBase{

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

  @override
  int getCodice() {
    return codTipologiaImmobile ?? 0;
  }

  @override
  String getDescrizione() {
    return descrizione ?? '';
  }

  @override
  String getNome() {
    return '';
  }

  @override
  int getOrdine() {
    return 0;
  }
}