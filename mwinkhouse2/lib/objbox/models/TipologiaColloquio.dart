import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaColloquio{

  @Id()
  int? codTipologiaColloquio;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaColloquio && this.codTipologiaColloquio == other.codTipologiaColloquio;

  @override
  int get hashCode => super.hashCode;
}