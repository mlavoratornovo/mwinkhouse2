import 'package:objectbox/objectbox.dart';

@Entity()
class TipologiaImmobile{

  @Id()
  int? codTipologiaImmobile;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is TipologiaImmobile && this.codTipologiaImmobile == other.codTipologiaImmobile;

  @override
  int get hashCode => super.hashCode;
}