import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaStanza{

  @Id()
  int? codTipologiaStanza;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaStanza && this.codTipologiaStanza == other.codTipologiaStanza;

  @override
  int get hashCode => super.hashCode;
}