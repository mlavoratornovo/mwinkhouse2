import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaContatto.dart';

import '../../main.dart';
import '../../objbox/models/Contatto.dart';

class DettaglioContatto extends StatefulWidget {
  final String title = 'Dettaglio contatto';
  Contatto? contatto;
  Anagrafica? anagrafica;
  DettaglioContatto({Key? key, this.anagrafica, this.contatto}) : super(key: key);

  @override
  State<DettaglioContatto> createState() => _DettaglioContattoState();
}

class _DettaglioContattoState extends State<DettaglioContatto> {

  List<TipologiaContatto> tipologiaContatto = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioContattoState(){
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
                        value: widget.contatto?.tipologiaContatto?.target,
                        onChanged: (TipologiaContatto? newValue) {
                          setState(() {
                            widget.contatto?.tipologiaContatto.target = newValue;
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
                            if (widget.contatto?.descrizione == null){
                              return 'Inserire il contatto';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          widget.contatto?.contatto = text;
                        },
                        initialValue: widget.contatto?.contatto ?? "",
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "descrizione"
                        ),
                        onChanged: (text) {
                          widget.contatto?.descrizione = text;
                        },
                        initialValue: widget.contatto?.descrizione ?? "",
                      ),
                    ])
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed:(widget.anagrafica==null)?null:() async {
            if (_formKey.currentState!.validate()) {
              widget.anagrafica?.contatti.add(widget.contatto!);
              Navigator.pop(context);
              // final value = await Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ContattiAnagraficaList(anagrafica:widget.anagrafica??Anagrafica())));
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