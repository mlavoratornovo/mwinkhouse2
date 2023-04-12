import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseCliente{
  ClasseCliente():super();
  @Id()
  int? codClasseCliente;

  String? descrizione;

  int? ordine;

  bool operator ==(dynamic other) =>
      other != null && other is ClasseCliente && this.codClasseCliente == other.codClasseCliente;

  @override
  int get hashCode => super.hashCode;

  factory ClasseCliente.fromJson(Map<String, dynamic> json){
    ClasseCliente instance = ClasseCliente();
    instance.codClasseCliente = json['codClasseCliente'];
    instance.descrizione = json['descrizione'];
    instance.ordine = json['ordine'];
    return instance;
  }
}