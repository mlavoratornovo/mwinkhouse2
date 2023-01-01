import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseEnergetica{

  @Id()
  int? codClasseEnergetica;

  String? nome;

  String? descrizione;

  int? ordine;

  bool operator ==(dynamic other) =>
      other != null && other is ClasseEnergetica && this.codClasseEnergetica == other.codClasseEnergetica;

  @override
  int get hashCode => super.hashCode;

}