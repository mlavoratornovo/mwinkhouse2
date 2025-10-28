import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../objbox/models/StanzaImmobile.dart';
import '../../objbox/models/TipologiaStanza.dart';
import 'dettaglio_immobile.dart';
import 'lista_stanze_immobile.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../objbox/models/Immobile.dart';

class DettaglioStanza extends StatefulWidget {
  final String title = 'Stanza';
  StanzaImmobile? stanzaImmobile;
  Immobile immobile;
  DettaglioStanza({super.key, required this.immobile, StanzaImmobile? stanzaImmobile}){
    this.stanzaImmobile = stanzaImmobile ?? StanzaImmobile();
  }

  @override
  State<DettaglioStanza> createState() => _DettaglioStanzaState(immobile, stanzaImmobile);
}

class _DettaglioStanzaState extends State<DettaglioStanza> {

  Immobile immobile;
  StanzaImmobile? stanzaImmobile;
  List<TipologiaStanza> tipologiaStanza = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioStanzaState(this.immobile,this.stanzaImmobile){
    stanzaImmobile = stanzaImmobile;
    tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Winkhouse $versione',)
                    ),  (r){
                      return false;
                    });
                  },
                  child: const Image(image: AssetImage("assets/images/wink75.png")),
                ),
                Text(widget.title)]
          ),
        ),
        body: Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Card(
          elevation: 4, // Ombra della card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0), // Padding interno alla Card
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child:Column(
                      children: <Widget>[
                        DropdownButtonFormField<TipologiaStanza>(
                          hint: const Text('Seleziona tipo stanza'),
                          validator: (value) => value == null ? 'Seleziona tipo' : null,
                          isExpanded: true,
                          value: stanzaImmobile?.tipologiaStanza.target,
                          onChanged: (TipologiaStanza? newValue) {
                            setState(() {
                              stanzaImmobile?.tipologiaStanza.target = newValue;
                            });
                          },
                          items: tipologiaStanza.map((TipologiaStanza tipologiaStanza) {
                            return DropdownMenuItem<TipologiaStanza>(
                              value: tipologiaStanza,
                              child: Text(
                                tipologiaStanza.descrizione??"",
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                        TextFormField(
                          decoration:const InputDecoration(
                              labelText: "Mq"
                          ),
                          validator:  (value) {
                            if (value == null || value.isEmpty) {
                              if (stanzaImmobile?.mq == null){
                                return 'Inserire la dimensione';
                              }
                            }
                            return null;
                          },
                          onChanged: (text) {
                            stanzaImmobile?.mq = int.parse(text);
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: "${stanzaImmobile?.mq ?? ""}",
                        ),
                      ])
              ),
            )
          )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              bool findit = false;
              for (var stanza in widget.immobile.stanze) {
                if (stanza.codStanzaImmobile ==
                    widget.stanzaImmobile?.codStanzaImmobile) {
                  findit = true;
                  break;
                }
              }
              if (!findit) {
                immobile.stanze.add(stanzaImmobile!);
                objectbox.addImmobile(immobile);
              }
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DettaglioImmobile(immobile: widget.immobile)
              ));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dati non validi impossibile procedere')),
              );
            }
          },
          child: const Icon(Icons.save),
        )
    );
  }

}