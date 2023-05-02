import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
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

  TipologiaImmobile? tipologieImmobileSelected;
  StatoConservativo? statoConservativoSelected;
  ClasseEnergetica? classeEnergeticaSelected;
  Riscaldamento? riscaldamentoSelected;
  TipologiaStanza? tipologiaStanzaSelected;
  ClasseCliente? classeClienteSelected;
  TipologiaContatto? tipologiaContattoSelected;

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

  Future<dynamic> _openPopUp(BuildContext context, String type) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Form(
                  key: _formKey,
                child:Column(
                  children: _getDialogWidgets(type),
                )
              ),
            ),
          );
        });
  }

  List<Widget> _getDialogWidgets(String type){
    List<Widget> widgets =  List<Widget>.empty(growable: true);
    if (type == 'TipologiaImmobile'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Tipologia immobile"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty || value.toString() == "") {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.tipologieImmobileSelected?.descrizione = text;
            },
            initialValue: "${(widget.tipologieImmobileSelected?.descrizione == null)?"":widget.tipologieImmobileSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.tipologieImmobileSelected != null) {
                  objectbox.tipologiaImmobileBox.put(
                      widget.tipologieImmobileSelected ?? TipologiaImmobile());
                }
                setState(() {
                  widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
                });
              }else{
                setState(() {
                  widget.tipologieImmobileSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
        )
      );
    }
    if (type == 'StatoConservativo'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Stato Conservativo"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.statoConservativoSelected?.descrizione = text;
            },
            initialValue: "${(widget.statoConservativoSelected?.descrizione == null)?"":widget.statoConservativoSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.statoConservativoSelected != null) {
                  objectbox.statoConservativoBox.put(widget.statoConservativoSelected??StatoConservativo());
                }
                setState(() {
                  widget.statoConservativo = objectbox.statoConservativoBox.getAll();
                });
              }else{
                setState(() {
                  widget.statoConservativoSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    if (type == 'ClasseEnergetica'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Classe Energetica"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire il nome';
              }
              return null;
            },
            onChanged: (text) {
              widget.classeEnergeticaSelected?.nome = text;
            },
            initialValue: "${(widget.classeEnergeticaSelected?.nome == null)?"":widget.classeEnergeticaSelected?.nome}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.classeEnergeticaSelected != null) {
                  objectbox.classeEnergeticaBox.put(
                      widget.classeEnergeticaSelected ?? ClasseEnergetica());
                  setState(() {
                    widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
                  });
                }
              }else{
                setState(() {
                  widget.classeEnergeticaSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    if (type == 'Riscaldamento'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Riscaldamento"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.riscaldamentoSelected?.descrizione = text;
            },
            initialValue: "${(widget.riscaldamentoSelected?.descrizione == null)?"":widget.riscaldamentoSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.riscaldamentoSelected != null) {
                  objectbox.riscaldamentoBox.put(
                      widget.riscaldamentoSelected ?? Riscaldamento());
                  setState(() {
                    widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
                  });

                }
              }else{
                setState(() {
                  widget.riscaldamentoSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    if (type == 'TipologiaStanza'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Tipologia Stanza"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.tipologiaStanzaSelected?.descrizione = text;
            },
            initialValue: "${(widget.tipologiaStanzaSelected?.descrizione == null)?"":widget.tipologiaStanzaSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.tipologiaStanzaSelected != null) {
                  objectbox.tipologiaStanzaBox.put(
                      widget.tipologiaStanzaSelected ?? TipologiaStanza());
                }
                setState(() {
                  widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
                });
              }else{
                setState(() {
                  widget.tipologiaStanzaSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    if (type == 'ClasseCliente'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Categoria Cliente"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty || value.toString() == "") {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.classeClienteSelected?.descrizione = text;
            },
            initialValue: "${(widget.classeClienteSelected?.descrizione == null)?"":widget.classeClienteSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.classeClienteSelected != null) {
                  objectbox.classeClienteBox.put(
                      widget.classeClienteSelected ?? ClasseCliente());
                  setState(() {
                    widget.classeCliente = objectbox.classeClienteBox.getAll();
                  });
                }
              }else{
                setState(() {
                  widget.classeClienteSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    if (type == 'Tipologia Contatto'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Tipologia Contatto"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.tipologiaContattoSelected?.descrizione = text;
            },
            initialValue: "${(widget.tipologiaContattoSelected?.descrizione == null)?"":widget.tipologiaContattoSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    color: Colors.blue,
                    width: 1.0,
                    style: BorderStyle.solid)
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.tipologiaContattoSelected != null) {
                  objectbox.tipologiaContattoBox.put(
                      widget.tipologiaContattoSelected ?? TipologiaContatto());
                  setState(() {
                    widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
                  });
                }
              }else{
                setState(() {
                  widget.tipologiaContattoSelected = null;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text("Salva"),
          )
      );

    }
    return widgets;
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
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                      Container(
                          child:Column(
                            children: [
                              DropdownButton<TipologiaImmobile>(
                                  hint: Text('Tipologie immobili'),
                                  isExpanded: true,
                                  value: widget.tipologieImmobileSelected,
                                  onChanged: (TipologiaImmobile? newValue) {
                                    setState(() {
                                      widget.tipologieImmobileSelected = newValue!;
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
                              Row(
                                  children: [

                                    Expanded(
                                          child:TextButton(
                                            child: Text("Modifica"),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.blue,
                                              side: const BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.0,
                                                  style: BorderStyle.solid)
                                            ),
                                            onPressed: () {
                                              _openPopUp(context,'TipologiaImmobile');
                                            },
                                          ),
                                    ),
                                    Expanded(
                                      child:TextButton(
                                        child: Text("Cancella"),
                                        style: TextButton.styleFrom(
                                            foregroundColor: Colors.blue,
                                            side: const BorderSide(
                                                color: Colors.blue,
                                                width: 1.0,
                                                style: BorderStyle.solid)
                                        ),
                                        onPressed: () {
                                          if (widget.tipologieImmobileSelected != null){
                                            objectbox.tipologiaImmobileBox.remove(widget.tipologieImmobileSelected?.codTipologiaImmobile??0);
                                            setState(() {
                                              widget.tipologieImmobileSelected = null;
                                              widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
                                            });
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Selezionare la tipologia')),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        child: TextButton(
                                          child: Text("Aggiungi"),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.blue,
                                            side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                          ),
                                          onPressed: () {
                                            widget.tipologieImmobileSelected = TipologiaImmobile();
                                            _openPopUp(context,'TipologiaImmobile');
                                          },
                                        )
                                    ),
                                  ],
                              ),
                            ]
                          ),
                      ),
                      Container(
                        child:Column(
                          children: [
                            DropdownButton<StatoConservativo>(
                              hint: Text('Stato Conservativo'),
                              isExpanded: true,
                              value: null,
                              onChanged: (StatoConservativo? newValue) {
                                setState(() {
                                  widget.statoConservativoSelected = newValue;
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
                            Row(
                              children: [

                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context,'StatoConservativo');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.statoConservativoSelected != null){
                                        objectbox.statoConservativoBox.remove(widget.statoConservativoSelected?.codStatoConservativo??0);
                                        setState(() {
                                          widget.statoConservativoSelected = null;
                                          widget.statoConservativo = objectbox.statoConservativoBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare lo stato')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.statoConservativoSelected = StatoConservativo();
                                        _openPopUp(context,'StatoConservativo');
                                      },
                                    )
                                ),
                              ],
                            ),
                           ],
                        )
                      ),
                      Container(
                        child: Column(
                          children: [
                            DropdownButton<ClasseEnergetica>(
                              hint: Text('Classe Energetica'),
                              isExpanded: true,
                              value: null,
                              onChanged: (ClasseEnergetica? newValue) {
                                setState(() {
                                  widget.classeEnergeticaSelected = newValue;
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
                            Row(
                              children: [

                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context,'ClasseEnergetica');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.classeEnergeticaSelected != null){
                                        objectbox.classeEnergeticaBox.remove(widget.classeEnergeticaSelected?.codClasseEnergetica??0);
                                        setState(() {
                                          widget.classeEnergeticaSelected = null;
                                          widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la classe energetica')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.classeEnergeticaSelected = ClasseEnergetica();
                                        _openPopUp(context,'ClasseEnergetica');
                                      },
                                    )
                                ),
                              ],
                            ),
                           ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            DropdownButton<Riscaldamento>(
                              hint: Text('Riscaldamento'),
                              isExpanded: true,
                              value: null,
                              onChanged: (Riscaldamento? newValue) {
                                setState(() {
                                  widget.riscaldamentoSelected = newValue;
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
                            Row(
                              children: [

                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context,'Riscaldamento');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.riscaldamentoSelected != null){
                                        objectbox.riscaldamentoBox.remove(widget.riscaldamentoSelected?.codRiscaldamento??0);
                                        setState(() {
                                          widget.riscaldamentoSelected = null;
                                          widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare il riscaldamento')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.riscaldamentoSelected = Riscaldamento();
                                        _openPopUp(context,'Riscaldamento');
                                      },
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            DropdownButton<TipologiaStanza>(
                              hint: Text('Tipologie stanze'),
                              isExpanded: true,
                              value: null,
                              onChanged: (TipologiaStanza? newValue) {
                                setState(() {
                                  widget.tipologiaStanzaSelected = newValue;
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
                            Row(
                              children: [

                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context,'TipologiaStanza');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.tipologiaStanzaSelected != null){
                                        objectbox.tipologiaStanzaBox.remove(widget.tipologiaStanzaSelected?.codTipologiaStanza??0);
                                        setState(() {
                                          widget.tipologiaStanzaSelected = null;
                                          widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la tipologia')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.tipologiaStanzaSelected = TipologiaStanza();
                                        _openPopUp(context,'TipologiaStanza');
                                      },
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            DropdownButton<ClasseCliente>(
                              hint: Text('Categoria Cliente'),
                              isExpanded: true,
                              value: null,
                              onChanged: (ClasseCliente? newValue) {
                                setState(() {
                                  widget.classeClienteSelected = newValue;
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
                            Row(
                              children: [
                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context, 'ClasseCliente');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.classeClienteSelected != null){
                                        objectbox.classeClienteBox.remove(widget.classeClienteSelected?.codClasseCliente??0);
                                        setState(() {
                                          widget.classeClienteSelected = null;
                                          widget.classeCliente = objectbox.classeClienteBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la categoria')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                          side: const BorderSide(
                                              color: Colors.blue,
                                              width: 1.0,
                                              style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.classeClienteSelected = ClasseCliente();
                                        _openPopUp(context, 'ClasseCliente');
                                      },
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            DropdownButton<TipologiaContatto>(
                              hint: Text('Tipologia Contatto'),
                              isExpanded: true,
                              value: null,
                              onChanged: (TipologiaContatto? newValue) {
                                setState(() {
                                  widget.tipologiaContattoSelected = newValue;
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
                            Row(
                              children: [
                                Expanded(
                                  child:TextButton(
                                    child: Text("Modifica"),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                      side: const BorderSide(
                                          color: Colors.blue,
                                          width: 1.0,
                                          style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      _openPopUp(context, 'TipologiaContatto');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    child: Text("Cancella"),
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                    ),
                                    onPressed: () {
                                      if (widget.tipologiaContattoSelected != null){
                                        objectbox.tipologiaContattoBox.remove(widget.tipologiaContattoSelected?.codTipologiaContatto??0);
                                        setState(() {
                                          widget.tipologiaContattoSelected = null;
                                          widget.tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
                                        });
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la tipologia')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                    child: TextButton(
                                      child: Text("Aggiungi"),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue,
                                        side: const BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                            style: BorderStyle.solid)
                                      ),
                                      onPressed: () {
                                        widget.tipologiaContattoSelected = TipologiaContatto();
                                        _openPopUp(context, 'TipologiaContatto');
                                      },
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ])
            ),
        ),
    );
  }
}