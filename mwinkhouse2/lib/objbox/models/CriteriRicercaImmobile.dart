
import 'package:mwinkhouse/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse/objbox/models/TipologiaImmobile.dart';


class CriteriRicercaImmobile{

  String indirizzo = '';
  String provincia = '';
  String cap = '';
  String citta = '';
  String zona = '';

  double prezzoDa = 0.0;
  double prezzoA = 0.0;
  int mqDa = 0;
  int mqA = 0;
  int annoCostruzioneDa = 0;
  int annoCostruzioneA = 0;
  Riscaldamento? riscaldamento;
  StatoConservativo? statoConservativo;
  TipologiaImmobile? tipologiaImmobile;
  ClasseEnergetica? classeEnergetica;

  void resetData(){
    indirizzo = '';
    provincia = '';
    cap = '';
    citta = '';
    zona = '';

    prezzoDa = 0.0;
    prezzoA = 0.0;
    mqDa = 0;
    mqA = 0;
    annoCostruzioneDa = 0;
    annoCostruzioneA = 0;
    riscaldamento = null;
    statoConservativo = null;
    tipologiaImmobile = null;
    classeEnergetica = null;

  }
}