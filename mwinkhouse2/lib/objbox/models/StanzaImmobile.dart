import 'package:objectbox/objectbox.dart';

import 'TipologiaStanza.dart';

@Entity()
class StanzaImmobile{

  StanzaImmobile():super();

  @Id()
  int? codStanzaImmobile;

  int? codImmobile;

  final tipologiaStanza = ToOne<TipologiaStanza>();

  int? mq;

  factory StanzaImmobile.fromJson(Map<String, dynamic> json){
    StanzaImmobile instance = StanzaImmobile();
    instance.codImmobile = json['codImmobile'];
    instance.codStanzaImmobile = json['codStanzaImmobile'];
    instance.mq = json['mq'];
    instance.tipologiaStanza.target = new TipologiaStanza();
    instance.tipologiaStanza.target?.codTipologiaStanza = json['codTipologiaStanza'];
    return instance;
  }

}
