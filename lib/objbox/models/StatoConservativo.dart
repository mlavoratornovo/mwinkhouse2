import 'package:objectbox/objectbox.dart';

import 'IDatiBase.dart';

@Entity()
class StatoConservativo implements IDatiBase{

  StatoConservativo():super();

  @Id()
  int? codStatoConservativo;

  String? descrizione;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is StatoConservativo && codStatoConservativo == other.codStatoConservativo;


  factory StatoConservativo.fromJson(Map<String, dynamic> json){
    StatoConservativo instance = StatoConservativo();
    instance.codStatoConservativo = json['codStatoConservativo'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

  @override
  int getCodice() {
    return codStatoConservativo ?? 0;
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
    codStatoConservativo = codice;
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