import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../../objbox/models/Anagrafica.dart';
import '../../main.dart';
import '../../objbox/models/Colloquio.dart';
import '../../objbox/models/TipologiaColloquio.dart';

import '../../constants.dart';
import 'dettaglio_anagrafica.dart';

class DettaglioColloquio extends StatefulWidget {
  final String title = 'Colloquio';
  Anagrafica anagrafica;
  Colloquio? colloquio;
  List<TipologiaColloquio> tipoColloquio = [];
  DettaglioColloquio({super.key,required this.anagrafica,this.colloquio}){
    colloquio?.dataColloquio ??= DateTime.now();
    tipoColloquio = objectbox.tipologiaColloquioBox.getAll().where((element) =>
    element.descrizione != 'Visita').toList();
  }

  @override
  State<DettaglioColloquio> createState() => _DettaglioColloquioState();
}

class _DettaglioColloquioState extends State<DettaglioColloquio> {

  final TextEditingController _tECDataInserimento = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _DettaglioColloquioState();

  _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime? newSelectedDate = await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 1, 1, 0, 0),
        maxTime: DateTime(2050, 12, 31, 23, 59),
        currentTime: DateTime.now()
    );
    if (newSelectedDate != null){
      widget.colloquio?.dataColloquio = newSelectedDate;
      _tECDataInserimento.text = newSelectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _tECDataInserimento.text = ((widget.colloquio!= null)?widget.colloquio?.dataColloquio.toString():"")!;
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
                        builder: (context) => const MyHomePage(title: 'Winkhouse $versione',)
                    ),  (r){
                      return false;
                    });
                  },
                  child: const Image(image: AssetImage("assets/images/wink75.png")),
                ),
                Text(widget.title)]
          ),
          actions: const [],
        ),
        body: Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Card(
            elevation: 4, // Ombra della card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0), // Padding interno alla Card
              child:Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child:Column(
                        children: <Widget>[
                          DropdownButtonFormField<TipologiaColloquio>(
                            validator: (value) => value == null ? 'Tipologia colloquio obbligatorio' : null,
                            isExpanded: true,
                            hint: const Text('Tipologia colloquio'),
                            value: widget.colloquio?.tipologiaColloquio.target,
                            onChanged: (TipologiaColloquio? newValue) {
                              setState(() {
                                widget.colloquio?.tipologiaColloquio.target = newValue;
                              });
                            },
                            items: widget.tipoColloquio.map((TipologiaColloquio tipologiaColloquio) {
                              return DropdownMenuItem<TipologiaColloquio>(
                                value: tipologiaColloquio,
                                child: Text(
                                  tipologiaColloquio.descrizione??"",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            decoration:const InputDecoration(
                                labelText: "Data colloquio"
                            ),
                            validator:  (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: _tECDataInserimento,
                            onTap: (){
                              _selectDate(context);
                            },
                            // initialValue: colloquio.dataColloquio.toString(),
                          ),
                          TextFormField(
                            maxLines: 5,
                            minLines: 3,
                            decoration:const InputDecoration(
                                labelText: "Descrizione"
                            ),
                            validator:  (value) {
                              if (value == null || value.isEmpty) {
                                if (widget.colloquio?.descrizione == null){
                                  return 'Please enter some text';
                                }
                              }
                              return null;
                            },
                            onChanged: (text) {
                              widget.colloquio?.descrizione = text;
                            },
                            initialValue: widget.colloquio?.descrizione ?? "",
                          ),
                          TextFormField(
                            maxLines: 5,
                            minLines: 3,
                            decoration:const InputDecoration(
                                labelText: "Agenzia"
                            ),
                            onChanged: (text) {
                              widget.colloquio?.commentoAgenzia = text;
                            },
                            initialValue: widget.colloquio?.commentoAgenzia,
                          ),
                          TextFormField(
                            maxLines: 5,
                            minLines: 3,
                            decoration:const InputDecoration(
                                labelText: "Cliente"
                            ),
                            onChanged: (text) {
                              widget.colloquio?.commentoCliente = text;
                            },
                            initialValue: widget.colloquio?.commentoCliente,
                          ),
                        ])
                ),
              ),
            )
          )
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed:() async {
            if (_formKey.currentState!.validate()) {
              bool findit = false;
              for (var colloquio in widget.anagrafica.colloqui) {
                if (colloquio.codColloquio == widget.colloquio?.codColloquio){
                  findit = true;
                }
              }
              if (!findit) {
                widget.anagrafica.colloqui.add(widget.colloquio ?? Colloquio());
                objectbox.addAnagrafica(widget.anagrafica ?? Anagrafica());
              }
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) => DettaglioAnagrafica(anagrafica: widget.anagrafica,)
              ),  (r){return false;});

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