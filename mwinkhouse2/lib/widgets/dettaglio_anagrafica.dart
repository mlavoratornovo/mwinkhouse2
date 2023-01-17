import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse2/main.dart';

import 'lista_contatti_anagrafica.dart';

class DettaglioAnagrafica extends StatefulWidget {
  final String title = 'Dettaglio anagrafica';
  Anagrafica anagrafica = Anagrafica();
  DettaglioAnagrafica({Key? key,required Anagrafica anagrafica}) : super(key: key){
    this.anagrafica = anagrafica ?? Anagrafica();
  }

  @override
  State<DettaglioAnagrafica> createState() => _DettaglioAnagraficaState(this.anagrafica);
}

class _DettaglioAnagraficaState extends State<DettaglioAnagrafica> {

  Anagrafica anagrafica;
  List<ClasseCliente> classeCliente = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioAnagraficaState(this.anagrafica){
    this.anagrafica = anagrafica;
    classeCliente = objectbox.classeClienteBox.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [
            PopupMenuButton(itemBuilder: (context)=>const [
              PopupMenuItem(child: Text('Contatti'), value:0),
              PopupMenuItem(child: Text('Immobili'), value:1),
              PopupMenuItem(child: Text('Colloqui'), value:2),
            ],
            onSelected: (result) {
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ContattiAnagraficaList(anagrafica: anagrafica)),
                  );
              }
            }
            )],

        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child:Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Cognome"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            if (this.anagrafica?.ragioneSociale == null){
                              return 'Please enter some text';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.cognome = text;
                        },
                        initialValue: "${this.anagrafica?.cognome ?? ""}",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Nome"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            if (this.anagrafica?.ragioneSociale == null){
                              return 'Please enter some text';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.nome = text;
                        },
                        initialValue: "${this.anagrafica?.nome ?? ""}",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Ragione sociale"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            if (this.anagrafica?.nome == null || this.anagrafica?.cognome == null){
                              return 'Please enter some text';
                            }
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.ragioneSociale = text;
                        },
                        initialValue: "${this.anagrafica?.ragioneSociale ?? ""}",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Partita iva"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.partitaIva = text;
                        },
                        initialValue: "${this.anagrafica?.partitaIva ?? ""}",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Codice fiscale"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.codiceFiscale = text;
                        },
                        initialValue: "${this.anagrafica?.codiceFiscale ?? ""}",
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: TextFormField(
                              decoration:const InputDecoration(
                                  labelText: "Provincia"
                              ),
                              validator:  (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                this.anagrafica?.provincia = text;
                              },
                              initialValue: "${this.anagrafica?.provincia ?? ""}",
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration:const InputDecoration(
                                  labelText: "Cap"
                              ),
                              validator:  (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (text) {
                                this.anagrafica?.cap = text;
                              },
                              initialValue: "${this.anagrafica?.cap ?? ""}",
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Città"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.citta = text;
                        },
                        initialValue: "${this.anagrafica?.citta ?? ""}",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Indirizzo"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.indirizzo = text;
                        },
                        initialValue: "${this.anagrafica?.indirizzo ?? ""}",
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "descrizione"
                        ),
                        validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          this.anagrafica?.commento = text;
                        },
                        initialValue: "${this.anagrafica?.commento ?? ""}",
                      ),
                      DropdownButton<ClasseCliente>(
                        isExpanded: true,
                        value: anagrafica?.classeCliente?.target,
                        onChanged: (ClasseCliente? newValue) {
                          setState(() {
                            anagrafica?.classeCliente.target = newValue;
                          });
                        },
                        items: classeCliente.map((ClasseCliente classeCliente) {
                          return DropdownMenuItem<ClasseCliente>(
                            value: classeCliente,
                            child: Text(
                              classeCliente.descrizione??"",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ])
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              objectbox.addAnagrafica(this.anagrafica ?? Anagrafica());
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