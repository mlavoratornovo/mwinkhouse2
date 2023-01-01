import 'package:objectbox/objectbox.dart';

@Entity()
class Immagine {

  @Id()
  int? codImmagine;
  int? codImmobile;
  int? ordine;
  String? pathImmagine;
  String? imgPropsStr;
  
}