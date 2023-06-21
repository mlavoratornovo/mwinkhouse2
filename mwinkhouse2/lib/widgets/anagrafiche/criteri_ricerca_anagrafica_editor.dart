import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/CriteriRicercaAnagrafica.dart';

import 'lista_anagrafiche_ricerca.dart';


class CriteriRicercaAnagraficaEditor extends StatefulWidget {
  final String title = 'Criteri ricerca immobile';
  final CriteriRicercaAnagrafica criteri = CriteriRicercaAnagrafica();
  CriteriRicercaAnagraficaEditor({Key? key}) : super(key: key){}

  @override
  State<CriteriRicercaAnagraficaEditor> createState() => _CriteriRicercaAnagraficaEditorState();
}

class _CriteriRicercaAnagraficaEditorState extends State<CriteriRicercaAnagraficaEditor> {

  List<ClasseCliente> classeCliente = [];

  final _formKey = GlobalKey<FormState>();

  _CriteriRicercaAnagraficaEditorState(){
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
                            labelText: "Indirizzo"
                        ),
                        onChanged: (text) {
                          widget.criteri.indirizzo = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Nome"
                        ),
                        onChanged: (text) {
                          widget.criteri.nome = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Cognome"
                        ),
                        onChanged: (text) {
                          widget.criteri.cognome = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Ragione sociale"
                        ),
                        onChanged: (text) {
                          widget.criteri.ragioneSociale = text;
                        },
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Codice fiscale"
                        ),
                        onChanged: (text) {
                          widget.criteri.codiceFiscale = text;
                        },
                      ),
                      DropdownButton<ClasseCliente>(
                        isExpanded: true,
                        hint: Text('Classe cliente'),
                        onChanged: (ClasseCliente? newValue) {
                          setState(() {
                            widget.criteri.classeCliente = newValue;
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
          heroTag: "Cerca",
          onPressed: () {
            if ((widget.criteri.provincia.trim() != '') ||
                (widget.criteri.cap.trim() != '') ||
                (widget.criteri.citta.trim() != '') ||
                (widget.criteri.indirizzo.trim() != '') ||
                (widget.criteri.nome.trim() != '') ||
                (widget.criteri.cognome.trim() != '') ||
                (widget.criteri.ragioneSociale.trim() != '') ||
                (widget.criteri.codiceFiscale.trim() != '') ||
                (widget.criteri.classeCliente != null)
            ) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AnagraficheRicercaList(criteri:widget.criteri)));
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