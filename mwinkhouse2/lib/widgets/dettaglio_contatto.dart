import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaContatto.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaStanza.dart';

import '../main.dart';
import '../objbox/models/Contatto.dart';
import '../objbox/models/Immobile.dart';

class DettaglioContatto extends StatefulWidget {
  final String title = 'Dettaglio contatto';
  Contatto? contatto;
  Anagrafica anagrafica;
  DettaglioContatto({Key? key, required this.anagrafica, Contatto? contatto}) : super(key: key){
    this.contatto = contatto ?? Contatto();
  }

  @override
  State<DettaglioContatto> createState() => _DettaglioContattoState(this.anagrafica, this.contatto);
}

class _DettaglioContattoState extends State<DettaglioContatto> {

  Anagrafica anagrafica;
  Contatto? contatto;
  List<TipologiaContatto> tipologiaContatto = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioContattoState(this.anagrafica,this.contatto){
    this.contatto = contatto;
    tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
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
                      DropdownButtonFormField<TipologiaContatto>(
                        hint: Text('Seleziona tipo contatto'),
                        validator: (value) => value == null ? 'Seleziona tipo' : null,
                        isExpanded: true,
                        value: contatto?.tipologiaContatto?.target,
                        onChanged: (TipologiaContatto? newValue) {
                          setState(() {
                            contatto?.tipologiaContatto.target = newValue;
                          });
                        },
                        items: tipologiaContatto.map((TipologiaContatto tipologiaContatto) {
                          return DropdownMenuItem<TipologiaContatto>(
                            value: tipologiaContatto,
                            child: Text(
                              tipologiaContatto.descrizione??"",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Contatto"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            if (this.contatto?.descrizione == null){
                              return 'Inserire il contatto';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.contatto?.contatto = text;
                        },
                        initialValue: "${this.contatto?.contatto ?? ""}",
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "descrizione"
                        ),
                        onChanged: (text) {
                          this.contatto?.descrizione = text;
                        },
                        initialValue: "${this.contatto?.descrizione ?? ""}",
                      ),
                    ])
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              anagrafica.contatti.add(contatto!);
              Navigator.pop(context);
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