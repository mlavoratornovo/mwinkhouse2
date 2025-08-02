import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class TipologiaContatto implements IDatiBase{

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

  @override
  int getCodice() {
    return codTipologiaContatto ?? 0;
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
    codTipologiaContatto = codice;
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