import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseCliente{

  @Id()
  int? codClasseCliente;

  String? descrizione;

  int? ordine;

  bool operator ==(dynamic other) =>
      other != null && other is ClasseCliente && this.codClasseCliente == other.codClasseCliente;

  @override
  int get hashCode => super.hashCode;
}