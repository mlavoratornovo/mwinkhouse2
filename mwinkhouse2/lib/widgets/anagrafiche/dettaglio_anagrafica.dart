import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/widgets/anagrafiche/lista_colloqui_anagrafica.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_immobili_proprieta.dart';

import 'lista_contatti_anagrafica.dart';

class DettaglioAnagrafica extends StatefulWidget {
  final String title = 'Dettaglio anagrafica';
  Anagrafica? _anagrafica = Anagrafica();
  DettaglioAnagrafica({Key? key,required Anagrafica anagrafica}) : super(key: key){
    this._anagrafica = anagrafica;
  }

  @override
  State<DettaglioAnagrafica> createState() => _DettaglioAnagraficaState(this._anagrafica);
}

class _DettaglioAnagraficaState extends State<DettaglioAnagrafica> {

  Anagrafica? _anagrafica;
  List<ClasseCliente> classeCliente = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioAnagraficaState(anagrafica){
    _anagrafica = anagrafica;
    classeCliente = objectbox.classeClienteBox.getAll();
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
                      ContattiAnagraficaList(anagrafica: _anagrafica??Anagrafica())),
                  );
              }
              if (result == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ImmobiliProprietaList(anagrafica: _anagrafica??Anagrafica())),
                );
              }
              if (result == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ColloquiAnagraficaList(anagrafica: _anagrafica??Anagrafica())),
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
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     if (_anagrafica?.ragioneSociale == null){
                        //       return 'Please enter some text';
                        //     }
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.cognome = (text.trim() == '')?null:text;
                        },
                        initialValue: _anagrafica?.cognome ?? "",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Nome"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     if (_anagrafica?.ragioneSociale == null){
                        //       return 'Please enter some text';
                        //     }
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.nome = (text.trim() == '')?null:text;
                        },
                        initialValue: _anagrafica?.nome ?? "",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Ragione sociale"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     if (_anagrafica?.nome == null || _anagrafica?.cognome == null){
                        //       return 'Please enter some text';
                        //     }
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.ragioneSociale = (text.trim() == '')?null:text;;
                        },
                        initialValue: _anagrafica?.ragioneSociale ?? "",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Partita iva"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Partita iva dato obbligatorio';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.partitaIva = text;
                        },
                        initialValue: _anagrafica?.partitaIva ?? "",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Codice fiscale"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Cofice fiscale dato obbligatorio';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.codiceFiscale = text;
                        },
                        initialValue: _anagrafica?.codiceFiscale ?? "",
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
                              // validator:  (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                              onChanged: (text) {
                                _anagrafica?.provincia = text;
                              },
                              initialValue: _anagrafica?.provincia ?? "",
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration:const InputDecoration(
                                  labelText: "Cap"
                              ),
                              // validator:  (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                              onChanged: (text) {
                                _anagrafica?.cap = text;
                              },
                              initialValue: _anagrafica?.cap ?? "",
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Città"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.citta = text;
                        },
                        initialValue: _anagrafica?.citta ?? "",
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Indirizzo"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.indirizzo = text;
                        },
                        initialValue: _anagrafica?.indirizzo ?? "",
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "descrizione"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          _anagrafica?.commento = text;
                        },
                        initialValue: _anagrafica?.commento ?? "",
                      ),
                      DropdownButtonFormField<ClasseCliente>(
                        hint: Text('Tipologia cliente'),
                        validator: (value) => value == null ? 'Tipologia dato obbligatorio' : null,
                        isExpanded: true,
                        value: _anagrafica?.classeCliente?.target,
                        onChanged: (ClasseCliente? newValue) {
                          setState(() {
                            _anagrafica?.classeCliente.target = newValue;
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
              if (_anagrafica?.cognome == null && _anagrafica?.nome == null && _anagrafica?.ragioneSociale == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }else{
                objectbox.addAnagrafica(_anagrafica ?? Anagrafica());
                Navigator.pop(context);
              }
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