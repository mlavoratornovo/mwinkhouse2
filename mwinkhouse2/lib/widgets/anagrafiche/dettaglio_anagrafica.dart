import 'dart:math';

import 'package:async_task/async_task_extension.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse/main.dart';
import 'package:mwinkhouse/widgets/anagrafiche/lista_colloqui_anagrafica.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili_proprieta.dart';

import '../immobili/lista_comuni_ricerca.dart';
import 'lista_contatti_anagrafica.dart';

class DettaglioAnagrafica extends StatefulWidget {
  final String title = 'Anagrafica';
  Anagrafica anagrafica;
  List<ClasseCliente> classeCliente = [];

  DettaglioAnagrafica({Key? key,required this.anagrafica}) : super(key: key){
    classeCliente = objectbox.classeClienteBox.getAll();
  }

  @override
  State<DettaglioAnagrafica> createState() => _DettaglioAnagraficaState();
}

class _DettaglioAnagraficaState extends State<DettaglioAnagrafica> {


  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
  }

  final _formKey = GlobalKey<FormState>();

  _DettaglioAnagraficaState();

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
                      ContattiAnagraficaList(anagrafica: widget.anagrafica)),
                  );
              }
              if (result == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ImmobiliProprietaList(anagrafica: widget.anagrafica)),
                );
              }
              if (result == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ColloquiAnagraficaList(anagrafica: widget.anagrafica)),
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
                        onChanged: (text) {
                          widget.anagrafica.cognome = (text.trim() == '')?null:text;
                        },
                        initialValue: widget.anagrafica.cognome ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Nome"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.nome = (text.trim() == '')?null:text;
                        },
                        initialValue: widget.anagrafica.nome ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Ragione sociale"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.ragioneSociale = (text.trim() == '')?null:text;;
                        },
                        initialValue: widget.anagrafica.ragioneSociale ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Partita iva"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.partitaIva = text;
                        },
                        initialValue: widget.anagrafica.partitaIva ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Codice fiscale"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.codiceFiscale = text;
                        },
                        initialValue: widget.anagrafica.codiceFiscale,
                        key: Key(Random().nextInt(10000).toString()),
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
                              onChanged: (text) {
                                widget.anagrafica.provincia = text;
                              },
                              initialValue: widget.anagrafica.provincia,
                              key: Key(Random().nextInt(10000).toString()),
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
                                widget.anagrafica.cap = text;
                              },
                              initialValue: widget.anagrafica.cap,
                              key: Key(Random().nextInt(10000).toString()),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        onTap: () async {
                          final value = await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ListaComuniRicerca(anagrafica:widget.anagrafica)
                          )
                          );
                          setState(() {});
                        },
                        decoration:const InputDecoration(
                            labelText: "Città"
                        ),
                        focusNode: focusNode,
                        onChanged: (text) {
                          widget.anagrafica.citta = text;
                        },
                        initialValue: widget.anagrafica.citta ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Indirizzo"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.indirizzo = text;
                        },
                        initialValue: widget.anagrafica.indirizzo ?? "",
                        key:Key(Random().nextInt(10000).toString()),
                      ),
                      TextFormField(
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "descrizione"
                        ),
                        onChanged: (text) {
                          widget.anagrafica.commento = text;
                        },
                        initialValue: widget.anagrafica.commento ?? "",
                        key: Key(Random().nextInt(10000).toString()),
                      ),
                      DropdownButtonFormField<ClasseCliente>(
                        hint: Text('Tipologia cliente'),
                        validator: (value) => value == null ? 'Tipologia dato obbligatorio' : null,
                        isExpanded: true,
                        value: widget.anagrafica.classeCliente.target,
                        onChanged: (ClasseCliente? newValue) {
                          setState(() {
                            widget.anagrafica.classeCliente.target = newValue;
                          });
                        },
                        items: widget.classeCliente.map((ClasseCliente classeCliente) {
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
              if (widget.anagrafica.cognome == null && widget.anagrafica.nome == null && widget.anagrafica.ragioneSociale == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dati non validi impossibile procedere')),
                );
              }else{
                objectbox.addAnagrafica(widget.anagrafica);
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