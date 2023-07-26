import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwinkhouse/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse/objbox/models/TipologiaStanza.dart';
import 'package:mwinkhouse/widgets/immobili/lista_stanze_immobile.dart';

import '../../main.dart';
import '../../objbox/models/Immobile.dart';

class DettaglioStanza extends StatefulWidget {
  final String title = 'Stanza';
  StanzaImmobile? stanzaImmobile;
  Immobile immobile;
  DettaglioStanza({Key? key, required this.immobile, StanzaImmobile? stanzaImmobile}) : super(key: key){
    this.stanzaImmobile = stanzaImmobile ?? StanzaImmobile();
  }

  @override
  State<DettaglioStanza> createState() => _DettaglioStanzaState(this.immobile, this.stanzaImmobile);
}

class _DettaglioStanzaState extends State<DettaglioStanza> {

  Immobile immobile;
  StanzaImmobile? stanzaImmobile;
  List<TipologiaStanza> tipologiaStanza = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioStanzaState(this.immobile,this.stanzaImmobile){
    this.stanzaImmobile = stanzaImmobile;
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
                        builder: (context) => const MyHomePage(title: 'Winkhouse 2.0.0',)
                    ),  (r){
                      return false;
                    });
                  },
                  child: const Image(image: AssetImage("assets/images/wink75.png")),
                ),
                Text(widget.title)]
          ),
          // actions: [
          //   PopupMenuButton(itemBuilder: (context)=>const [
          //     PopupMenuItem(child: Text('Contatti')),
          //     PopupMenuItem(child: Text('Immobili')),
          //     PopupMenuItem(child: Text('Colloqui')),
          //   ]
          //   )],
        ),
        body: Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child:Column(
                    children: <Widget>[
                      DropdownButtonFormField<TipologiaStanza>(
                        hint: Text('Seleziona tipo stanza'),
                        validator: (value) => value == null ? 'Seleziona tipo' : null,
                        isExpanded: true,
                        value: stanzaImmobile?.tipologiaStanza?.target,
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
                            if (this.stanzaImmobile?.mq == null){
                              return 'Inserire la dimensione';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.stanzaImmobile?.mq = int.parse(text);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        initialValue: "${this.stanzaImmobile?.mq ?? ""}",
                      ),
                    ])
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              immobile.stanze.add(stanzaImmobile!);
              objectbox.addImmobile(immobile);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StanzeImmobileList(immobile: widget.immobile)
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