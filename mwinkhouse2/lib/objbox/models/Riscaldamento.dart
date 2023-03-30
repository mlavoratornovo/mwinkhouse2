import 'package:objectbox/objectbox.dart';

@Entity()
class Riscaldamento{

  Riscaldamento():super();

  @Id()
  int? codRiscaldamento;

  String? descrizione;

  bool operator ==(dynamic other) =>
      other != null && other is Riscaldamento && this.codRiscaldamento == other.codRiscaldamento;

  @override
  int get hashCode => super.hashCode;

  factory Riscaldamento.fromJson(Map<String, dynamic> json){
    Riscaldamento instance = Riscaldamento();
    instance.codRiscaldamento = json['codRiscaldamento'];
    instance.descrizione = json['descrizione'];
    return instance;
  }
}