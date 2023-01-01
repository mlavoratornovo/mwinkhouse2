import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaAppuntamento{

  @Id()
  int? codTipologiaAppuntamento;

  String? descrizione;

  String? gCalColor;

  int? ordine;

}