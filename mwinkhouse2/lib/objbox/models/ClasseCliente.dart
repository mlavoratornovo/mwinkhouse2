import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseCliente{

  @Id()
  int? codClasseCliente;

  String? descrizione;

  int? ordine;

}