import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class TipologiaStanza implements IDatiBase{

  TipologiaStanza():super();
  @Id()
  int? codTipologiaStanza;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is TipologiaStanza && codTipologiaStanza == other.codTipologiaStanza;


  factory TipologiaStanza.fromJson(Map<String, dynamic> json){
    TipologiaStanza instance = TipologiaStanza();
    instance.codTipologiaStanza = json['codTipologiaStanza'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

  @override
  int getCodice() {
    return codTipologiaStanza ?? 0;
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

  @override
  void setCodice(int codice) {
    codTipologiaStanza = codice;
  }

  @override
  void setDescrizione(String descrizione) {
    this.descrizione = descrizione;
  }

  @override
  void setNome(String nome) {
    // TODO: implement setNome
  }

  @override
  void setOrdine(int ordine) {
    // TODO: implement setOrdine
  }

}