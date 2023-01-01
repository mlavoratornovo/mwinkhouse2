import 'package:mwinkhouse2/objbox/models/TipologiaContatto.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contatto{
  @Id()
  int? codContatto;
  String? contatto;
  String? descrizione;
  int? codTipologiaContatto;
  int? codAnagrafica;
  int? codAgente;
  final tipologiaContatto = ToOne<TipologiaContatto>();

}