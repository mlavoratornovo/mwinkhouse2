import 'package:objectbox/objectbox.dart';

@Entity()
class Riscaldamento{

  @Id()
  int? codRiscaldamento;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is Riscaldamento && this.codRiscaldamento == other.codRiscaldamento;

  @override
  int get hashCode => super.hashCode;

}