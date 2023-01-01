import 'dart:ffi';
import 'package:objectbox/objectbox.dart';

@Entity()
class DatiCatastali {

  @Id()
  int? codDatiCatastali;
  String? foglio;
  String? particella;
  String? subalterno;
  String? categoria;
  double? rendita;
  double? redditoDomenicale;
  double? redditoAgricolo;
  double? dimensione;
  int? codImmobile;
}