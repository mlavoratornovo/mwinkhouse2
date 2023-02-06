import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';

import '../../objbox/models/Anagrafica.dart';
import '../../objbox/models/CriteriRicercaImmobile.dart';
import 'lista_immobili_ricerca.dart';

class CriteriRicercaImmobileEditor extends StatefulWidget {
  final String title = 'Criteri ricerca immobile';
  final CriteriRicercaImmobile criteri = CriteriRicercaImmobile();
  CriteriRicercaImmobileEditor({Key? key}) : super(key: key){}

  @override
  State<CriteriRicercaImmobileEditor> createState() => _CriteriRicercaImmobileEditorState();
}

class _CriteriRicercaImmobileEditorState extends State<CriteriRicercaImmobileEditor> {

  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];

  final _formKey = GlobalKey<FormState>();

  _CriteriRicercaImmobileState(){
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
        ),
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
                                 widget.criteri.provincia = text;
                              },
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
                                widget.criteri.cap = text;
                              },
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Città"
                        ),
                        onChanged: (text) {
                          widget.criteri.citta = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Zona"
                        ),
                        onChanged: (text) {
                          widget.criteri.zona = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Indirizzo"
                        ),
                        onChanged: (text) {
                          widget.criteri.indirizzo = text;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: TextFormField(
                              decoration:const InputDecoration(
                                  labelText: "Prezzo da "
                              ),
                              onChanged: (text) {
                                widget.criteri.prezzoDa = double.parse(text);
                              },
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
                                  labelText: "Prezzo a "
                              ),
                              onChanged: (text) {
                                widget.criteri.prezzoA = double.parse(text);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
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
                                  labelText: "Mq da "
                              ),
                              onChanged: (text) {
                                widget.criteri.mqDa = int.parse(text);
                              },
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
                                  labelText: "Mq a "
                              ),
                              onChanged: (text) {
                                widget.criteri.mqA = int.parse(text);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
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
                                  labelText: "Anno costruzione da "
                              ),
                              onChanged: (text) {
                                widget.criteri.annoCostruzioneDa = int.parse(text);
                              },
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
                                  labelText: "Anno costruzione a "
                              ),
                              onChanged: (text) {
                                widget.criteri.annoCostruzioneA = int.parse(text);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<TipologiaImmobile>(
                        isExpanded: true,
                        hint: Text('Tipologia immobile'),
                        onChanged: (TipologiaImmobile? newValue) {
                          setState(() {
                            widget.criteri.tipologiaImmobile = newValue;
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
                        onChanged: (StatoConservativo? newValue) {
                          setState(() {
                            widget.criteri.statoConservativo = newValue;
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
                        onChanged: (ClasseEnergetica? newValue) {
                          setState(() {
                            widget.criteri.classeEnergetica = newValue;
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
                        onChanged: (Riscaldamento? newValue) {
                          setState(() {
                            widget.criteri.riscaldamento = newValue;
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
          heroTag: "Cerca",
          onPressed: () {
            if ((widget.criteri.provincia != null && widget.criteri.provincia?.trim() != '') ||
                (widget.criteri.cap != null && widget.criteri.cap?.trim() != '') ||
                (widget.criteri.citta != null && widget.criteri.citta?.trim() != '') ||
                (widget.criteri.zona != null && widget.criteri.zona?.trim() != '') ||
                (widget.criteri.indirizzo != null && widget.criteri.indirizzo?.trim() != '') ||
                (widget.criteri.prezzoDa != null) || (widget.criteri.prezzoA != null) ||
                (widget.criteri.mqDa != null) || (widget.criteri.mqA != null) ||
                (widget.criteri.annoCostruzioneDa != null) || (widget.criteri.annoCostruzioneA != null) ||
                (widget.criteri.classeEnergetica != null) || (widget.criteri.riscaldamento != null) ||
                (widget.criteri.tipologiaImmobile != null) || (widget.criteri.statoConservativo != null)
            ) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImmobiliRicercaList(criteri:widget.criteri)));
              }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dati non validi impossibile procedere')),
              );
            }
          },
          child: const Icon(Icons.find_in_page),
        )
    );
  }


}