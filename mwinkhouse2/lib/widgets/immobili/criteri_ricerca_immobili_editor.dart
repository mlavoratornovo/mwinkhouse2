import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_immobili_ricerca_rest.dart';

import '../../objbox/models/Anagrafica.dart';
import '../../objbox/models/CriteriRicercaImmobile.dart';
import 'lista_immobili_ricerca.dart';

class CriteriRicercaImmobileEditor extends StatefulWidget {
  final String title = 'Ricerca immobile';
  final CriteriRicercaImmobile criteri = CriteriRicercaImmobile();
  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];

  CriteriRicercaImmobileEditor({Key? key}) : super(key: key){
    tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
    statoConservativo = objectbox.statoConservativoBox.getAll();
    classeEnergetica = objectbox.classeEnergeticaBox.getAll();
    riscaldamento = objectbox.riscaldamentoBox.getAll();
  }

  @override
  State<CriteriRicercaImmobileEditor> createState() => _CriteriRicercaImmobileEditorState();
}

class _CriteriRicercaImmobileEditorState extends State<CriteriRicercaImmobileEditor> {


  final _formKey = GlobalKey<FormState>();

  _CriteriRicercaImmobileEditorState(){
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
                const SizedBox(width: 4),
                Text(widget.title)]
          ),
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
                        value: widget.criteri.tipologiaImmobile,
                        items: widget.tipologieImmobile.map((TipologiaImmobile tipologiaImmobile) {
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
                        value: widget.criteri.statoConservativo,
                        items: widget.statoConservativo.map((StatoConservativo statoConservativo) {
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
                        value: widget.criteri.classeEnergetica,
                        items: widget.classeEnergetica.map((ClasseEnergetica classeEnergetica) {
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
                        value: widget.criteri.riscaldamento,
                        items: widget.riscaldamento.map((Riscaldamento riscaldamento) {
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
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [FloatingActionButton(
          heroTag: "Cerca",
          onPressed: () {
            if ((widget.criteri.provincia.trim() != '') ||
                (widget.criteri.cap.trim() != '') ||
                (widget.criteri.citta.trim() != '') ||
                (widget.criteri.zona.trim() != '') ||
                (widget.criteri.indirizzo?.trim() != '') ||
                (widget.criteri.prezzoDa != 0.0) || (widget.criteri.prezzoA != 0.0) ||
                (widget.criteri.mqDa != 0) || (widget.criteri.mqA != 0) ||
                (widget.criteri.annoCostruzioneDa != 0) || (widget.criteri.annoCostruzioneA != 0) ||
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
        ),
        FloatingActionButton(
          heroTag: "Reset",
          onPressed: () {
            widget.criteri.resetData();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration.zero,
                pageBuilder: (_, __, ___) => CriteriRicercaImmobileEditor(),
              ),
            );          },
          child: const Icon(Icons.cleaning_services_outlined),
        )
        ])
    );
  }


}