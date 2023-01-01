import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaStanza{

  @Id()
  int? codTipologiaStanza;

  String? descrizione;

}