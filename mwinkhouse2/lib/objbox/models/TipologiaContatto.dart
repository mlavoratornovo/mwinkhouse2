import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaContatto{

  @Id()
  int? codTipologiaContatto;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaContatto && this.codTipologiaContatto == other.codTipologiaContatto;

  @override
  int get hashCode => super.hashCode;
}