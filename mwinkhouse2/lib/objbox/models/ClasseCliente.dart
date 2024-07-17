import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseCliente{
  ClasseCliente():super();
  @Id()
  int? codClasseCliente;

  String? descrizione;

  int? ordine;

  @override
  bool operator ==(dynamic other) =>
      other != null && other is ClasseCliente && codClasseCliente == other.codClasseCliente;


  factory ClasseCliente.fromJson(Map<String, dynamic> json){
    ClasseCliente instance = ClasseCliente();
    instance.codClasseCliente = json['codClasseCliente'];
    instance.descrizione = json['descrizione'];
    instance.ordine = json['ordine'];
    return instance;
  }
}