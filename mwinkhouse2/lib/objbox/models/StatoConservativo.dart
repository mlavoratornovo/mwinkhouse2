import 'package:objectbox/objectbox.dart';

@Entity()
class StatoConservativo{

  @Id()
  int? codStatoConservativo;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is StatoConservativo && this.codStatoConservativo == other.codStatoConservativo;

  @override
  int get hashCode => super.hashCode;

}