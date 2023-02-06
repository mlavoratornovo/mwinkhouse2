import 'dart:ffi';

import 'package:mwinkhouse2/objbox/models/Agente.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Immagine.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:objectbox/objectbox.dart';

import 'Anagrafica.dart';
import 'Colloquio.dart';

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

}