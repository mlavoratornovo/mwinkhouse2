import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_stanze_immobile.dart';

import '../anagrafiche/lista_anagrafiche_proprieta.dart';
import 'lista_colloqui_immobile.dart';

class DettaglioImmobile extends StatefulWidget {
  final String title = 'Dettaglio immobile';
  Immobile? _immobile;
  DettaglioImmobile({Key? key, required Immobile immobile}) : super(key: key){
    _immobile = immobile;
  }

  @override
  State<DettaglioImmobile> createState() => _DettaglioImmobileState(_immobile);
}

class _DettaglioImmobileState extends State<DettaglioImmobile> {

  Immobile? _immobile;
  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];

  final _formKey = GlobalKey<FormState>();

  _DettaglioImmobileState(immobile){
    _immobile = immobile;
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
                    MaterialPageRoute(builder: (context) => AnagraficheProprietaList(immobile:_immobile??Immobile())),
                  );
                }
                if (result == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StanzeImmobileList(immobile:_immobile??Immobile())),
                  );
                }
                if (result == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColloquiImmobileList(immobile:_immobile??Immobile())),
                  );
                }
                if (result == 4){
                  MapsLauncher.launchQuery("${(widget._immobile?.indirizzo??'')}, ${(widget._immobile?.citta??'')}, ${(widget._immobile?.provincia??'')} ${(widget._immobile?.cap??'')}");
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
                      onChanged: (text) {
                        _immobile?.provincia = text;
                      },
                      initialValue: "${_immobile?.provincia ?? ""}",
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration:const InputDecoration(
                          labelText: "Cap"
                      ),
                      onChanged: (text) {
                        _immobile?.cap = text;
                      },
                      initialValue: _immobile?.cap ?? "",
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
                    return 'Città dato obbligatorio';
                  }
                  return null;
                },
                onChanged: (text) {
                  _immobile?.citta = text;
                },
                initialValue: "${_immobile?.citta ?? ""}",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Zona"
                ),
                onChanged: (text) {
                  _immobile?.zona = text;
                },
                initialValue: _immobile?.zona ?? "",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Indirizzo"
                ),
                validator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Indirizzo dato obbligatorio';
                  }
                  return null;
                },
                onChanged: (text) {
                  _immobile?.indirizzo = text;
                },
                initialValue: _immobile?.indirizzo ?? "",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Prezzo"
                ),
                onChanged: (text) {
                  _immobile?.prezzo = double.parse(text);
                },
                initialValue: "${_immobile?.prezzo ?? ""}",
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
                      onChanged: (text) {
                        _immobile?.mq = int.parse(text);
                      },
                      initialValue: "${_immobile?.mq ?? ""}",
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
                      onChanged: (text) {
                        _immobile?.annoCostruzione = int.parse(text);
                      },
                      initialValue: "${_immobile?.annoCostruzione ?? ""}",
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
                onChanged: (text) {
                  _immobile?.descrizione = text;
                },
                initialValue: _immobile?.descrizione ?? "",
              ),
              DropdownButtonFormField<TipologiaImmobile>(
                isExpanded: true,
                hint: Text('Tipologia immobile'),
                validator: (value) => value == null ? 'Tipologia dato obbligatorio' : null,
                value: _immobile?.tipologiaImmobile?.target,
                onChanged: (TipologiaImmobile? newValue) {
                  setState(() {
                    _immobile?.tipologiaImmobile.target = newValue;
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
                hint: Text('Stato conservativo'),
                value: _immobile?.statoConservativo?.target,
                onChanged: (StatoConservativo? newValue) {
                  setState(() {
                    _immobile?.statoConservativo.target = newValue;
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
                hint: Text('Class energetica'),
                value: _immobile?.classeEnergetica?.target,
                onChanged: (ClasseEnergetica? newValue) {
                  setState(() {
                    _immobile?.classeEnergetica.target = newValue;
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
                hint: Text('Riscaldamento'),
                value: _immobile?.riscaldamento?.target,
                onChanged: (Riscaldamento? newValue) {
                  setState(() {
                    _immobile?.riscaldamento.target = newValue;
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
          objectbox.addImmobile(_immobile ?? Immobile());
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