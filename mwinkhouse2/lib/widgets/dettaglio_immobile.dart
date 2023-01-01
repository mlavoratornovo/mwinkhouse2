import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';

import 'lista_anagrafiche.dart';

class DettaglioImmobile extends StatefulWidget {
  final String title = 'Dettaglio immobile';
  Immobile? immobile;
  DettaglioImmobile({Key? key, this.immobile}) : super(key: key){
    this.immobile = immobile ?? Immobile();
  }

  @override
  State<DettaglioImmobile> createState() => _DettaglioImmobileState(this.immobile);
}

class _DettaglioImmobileState extends State<DettaglioImmobile> {

  Immobile? immobile;
  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioImmobileState(this.immobile){
    this.immobile = immobile;
    tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
    statoConservativo = objectbox.statoConservativoBox.getAll();
    classeEnergetica = objectbox.classeEnergeticaBox.getAll();
    riscaldamento = objectbox.riscaldamentoBox.getAll();
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
              PopupMenuItem(child: Text('Stanze'), value: 0),
              PopupMenuItem(child: Text('Propietari'), value: 1),
              PopupMenuItem(child: Text('Immagini'), value: 2),
              PopupMenuItem(child: Text('Colloqui'), value: 3),
              PopupMenuItem(child: Text('Mappa'), value: 4),
            ],
              onSelected: (result) {
                if (result == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnagraficheList(immobile:immobile)),
                  );
                }
                },
            )]),
    body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:Column(
            children: <Widget>[
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
                        this.immobile?.provincia = text;
                      },
                      initialValue: "${this.immobile?.provincia ?? ""}",
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
                        this.immobile?.cap = text;
                      },
                      initialValue: "${this.immobile?.cap ?? ""}",
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
                  this.immobile?.citta = text;
                },
                initialValue: "${this.immobile?.citta ?? ""}",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Zona"
                ),
                validator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (text) {
                  this.immobile?.zona = text;
                },
                initialValue: "${this.immobile?.zona ?? ""}",
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
                  this.immobile?.indirizzo = text;
                },
                initialValue: "${this.immobile?.indirizzo ?? ""}",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Prezzo"
                ),
                validator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (text) {
                  this.immobile?.prezzo = double.parse(text);
                },
                initialValue: "${this.immobile?.prezzo ?? ""}",
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration:const InputDecoration(
                          labelText: "Mq"
                      ),
                      validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        this.immobile?.mq = int.parse(text);
                      },
                      initialValue: "${this.immobile?.mq ?? ""}",
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration:const InputDecoration(
                          labelText: "Anno Costruzione"
                      ),
                      validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        this.immobile?.annoCostruzione = int.parse(text);
                      },
                      initialValue: "${this.immobile?.annoCostruzione ?? ""}",
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
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
                  this.immobile?.descrizione = text;
                },
                initialValue: "${this.immobile?.descrizione ?? ""}",
              ),
              DropdownButton<TipologiaImmobile>(
                isExpanded: true,
                value: immobile?.tipologiaImmobile?.target,
                onChanged: (TipologiaImmobile? newValue) {
                  setState(() {
                    immobile?.tipologiaImmobile.target = newValue;
                  });
                },
                items: tipologieImmobile.map((TipologiaImmobile tipologiaImmobile) {
                  return DropdownMenuItem<TipologiaImmobile>(
                    value: tipologiaImmobile,
                    child: Text(
                      tipologiaImmobile.descrizione??"",
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              DropdownButton<StatoConservativo>(
                isExpanded: true,
                value: immobile?.statoConservativo?.target,
                onChanged: (StatoConservativo? newValue) {
                  setState(() {
                    immobile?.statoConservativo.target = newValue;
                  });
                },
                items: statoConservativo.map((StatoConservativo statoConservativo) {
                  return DropdownMenuItem<StatoConservativo>(
                    value: statoConservativo,
                    child: Text(
                      statoConservativo.descrizione??"",
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              DropdownButton<ClasseEnergetica>(
                isExpanded: true,
                value: immobile?.classeEnergetica?.target,
                onChanged: (ClasseEnergetica? newValue) {
                  setState(() {
                    immobile?.classeEnergetica.target = newValue;
                  });
                },
                items: classeEnergetica.map((ClasseEnergetica classeEnergetica) {
                  return DropdownMenuItem<ClasseEnergetica>(
                    value: classeEnergetica,
                    child: Text(
                      classeEnergetica.nome??"",
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
              DropdownButton<Riscaldamento>(
                isExpanded: true,
                value: immobile?.riscaldamento?.target,
                onChanged: (Riscaldamento? newValue) {
                  setState(() {
                    immobile?.riscaldamento.target = newValue;
                  });
                },
                items: riscaldamento.map((Riscaldamento riscaldamento) {
                  return DropdownMenuItem<Riscaldamento>(
                    value: riscaldamento,
                    child: Text(
                      riscaldamento.descrizione??"",
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
          objectbox.addImmobile(this.immobile ?? Immobile());
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