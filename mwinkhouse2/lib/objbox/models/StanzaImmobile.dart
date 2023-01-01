import 'package:objectbox/objectbox.dart';

import 'TipologiaStanza.dart';

@Entity()
class StanzaImmobile{

  @Id()
  int? codStanzaImmobile;

  int? codImmobile;

  final tipologiaStanza = ToOne<TipologiaStanza>();

  int? mq;

}
