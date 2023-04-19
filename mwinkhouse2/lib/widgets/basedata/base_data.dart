import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../objbox/models/ClasseCliente.dart';
import '../../objbox/models/ClasseEnergetica.dart';
import '../../objbox/models/Riscaldamento.dart';
import '../../objbox/models/StatoConservativo.dart';
import '../../objbox/models/TipologiaContatto.dart';
import '../../objbox/models/TipologiaImmobile.dart';
import '../../objbox/models/TipologiaStanza.dart';

class BaseData extends StatefulWidget {

  final String title = 'Categorie';

  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];
  List<TipologiaStanza> tipologiaStanza = [];
  List<ClasseCliente> classeCliente = [];
  List<TipologiaContatto> tipologiaContatto = [];

  BaseData({Key? key}) : super(key: key){
    tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
    statoConservativo = objectbox.statoConservativoBox.getAll();
    classeEnergetica = objectbox.classeEnergeticaBox.getAll();
    riscaldamento = objectbox.riscaldamentoBox.getAll();
    tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
    classeCliente = objectbox.classeClienteBox.getAll();
    tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
  }

  @override
  State<BaseData> createState() => _BaseDataState();
}

class _BaseDataState extends State<BaseData> {

  final _formKey = GlobalKey<FormState>();

  _BaseDataState();

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
                child: Column(
                    children: <Widget>[
                      DropdownButton<TipologiaImmobile>(
                        hint: Text('Tipologie immobili'),
                        isExpanded: true,
                        value: null,
                        onChanged: (TipologiaImmobile? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.tipologieImmobile.map((
                            TipologiaImmobile tipologiaImmobile) {
                          return DropdownMenuItem<TipologiaImmobile>(
                            value: tipologiaImmobile,
                            child: Text(
                              tipologiaImmobile.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<StatoConservativo>(
                        hint: Text('Stato Conservativo'),
                        isExpanded: true,
                        value: null,
                        onChanged: (StatoConservativo? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.statoConservativo.map((
                            StatoConservativo statoConservativo) {
                          return DropdownMenuItem<StatoConservativo>(
                            value: statoConservativo,
                            child: Text(
                              statoConservativo.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<ClasseEnergetica>(
                        hint: Text('Classe Energetica'),
                        isExpanded: true,
                        value: null,
                        onChanged: (ClasseEnergetica? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.classeEnergetica.map((
                            ClasseEnergetica classeEnergetica) {
                          return DropdownMenuItem<ClasseEnergetica>(
                            value: classeEnergetica,
                            child: Text(
                              classeEnergetica.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<Riscaldamento>(
                        hint: Text('Riscaldamento'),
                        isExpanded: true,
                        value: null,
                        onChanged: (Riscaldamento? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.riscaldamento.map((
                            Riscaldamento riscaldamento) {
                          return DropdownMenuItem<Riscaldamento>(
                            value: riscaldamento,
                            child: Text(
                              riscaldamento.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<TipologiaStanza>(
                        hint: Text('Tipologie stanze'),
                        isExpanded: true,
                        value: null,
                        onChanged: (TipologiaStanza? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.tipologiaStanza.map((
                            TipologiaStanza tipologiaStanza) {
                          return DropdownMenuItem<TipologiaStanza>(
                            value: tipologiaStanza,
                            child: Text(
                              tipologiaStanza.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<ClasseCliente>(
                        hint: Text('Classe Cliente'),
                        isExpanded: true,
                        value: null,
                        onChanged: (ClasseCliente? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.classeCliente.map((
                            ClasseCliente classeCliente) {
                          return DropdownMenuItem<ClasseCliente>(
                            value: classeCliente,
                            child: Text(
                              classeCliente.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      DropdownButton<TipologiaContatto>(
                        hint: Text('Tipologia Contatto'),
                        isExpanded: true,
                        value: null,
                        onChanged: (TipologiaContatto? newValue) {
                          setState(() {
                            //stanzaImmobile?.tipologiaStanza.target = newValue;
                          });
                        },
                        items: widget.tipologiaContatto.map((
                            TipologiaContatto tipologiaContatto) {
                          return DropdownMenuItem<TipologiaContatto>(
                            value: tipologiaContatto,
                            child: Text(
                              tipologiaContatto.descrizione ?? "",
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ])
            ),
          ),
        ),
    );
  }
}