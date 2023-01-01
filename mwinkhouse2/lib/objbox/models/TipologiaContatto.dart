import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaContatto{

  @Id()
  int? codTipologiaContatto;

  String? descrizione;

}