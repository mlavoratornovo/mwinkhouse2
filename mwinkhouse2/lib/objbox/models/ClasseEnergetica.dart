import 'package:objectbox/objectbox.dart';

@Entity()
class ClasseEnergetica{

  ClasseEnergetica():super();

  @Id()
  int? codClasseEnergetica;

  String? nome;

  String? descrizione;

  int? ordine;

  bool operator ==(dynamic other) =>
      other != null && other is ClasseEnergetica && this.codClasseEnergetica == other.codClasseEnergetica;

  @override
  int get hashCode => super.hashCode;

  factory ClasseEnergetica.fromJson(Map<String, dynamic> json){
    ClasseEnergetica instance = ClasseEnergetica();
    instance.codClasseEnergetica = json['codClasseEnergetica'];
    instance.descrizione = json['descrizione'];
    return instance;
  }

}