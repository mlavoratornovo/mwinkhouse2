import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Colloquio.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaColloquio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DettaglioColloquio extends StatefulWidget {
  String title = '';
  Anagrafica? anagrafica;
  Colloquio colloquio = Colloquio();
  DettaglioColloquio({Key? key,this.anagrafica,required Colloquio colloquio}) : super(key: key){
    title = "Dettaglio colloquio : ${(anagrafica?.ragioneSociale ?? "")} ${(anagrafica?.nome ?? "")} ${(anagrafica?.cognome ?? "")}";
  }

  @override
  State<DettaglioColloquio> createState() => _DettaglioColloquioState();
}

class _DettaglioColloquioState extends State<DettaglioColloquio> {

  List<TipologiaColloquio> tipoColloquio = [];

  final TextEditingController _tECDataInserimento = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _DettaglioColloquioState(){
    tipoColloquio = objectbox.tipologiaColloquioBox.getAll().where((element) =>
    element.descrizione != 'Visita').toList();
  }

  _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime? newSelectedDate = await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2020, 1, 1, 0, 0),
        maxTime: DateTime(2050, 12, 31, 23, 59),
        currentTime: DateTime.now()
    );
    if (newSelectedDate != null){
      _tECDataInserimento.text = newSelectedDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _tECDataInserimento.text = widget.colloquio.dataColloquio.toString();
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: [],
        ),
        body: Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child:Column(
                    children: <Widget>[
                      DropdownButtonFormField<TipologiaColloquio>(
                        validator: (value) => value == null ? 'Tipologia colloquio obbligatorio' : null,
                        isExpanded: true,
                        value: widget.colloquio?.tipologiaColloquio.target,
                        onChanged: (TipologiaColloquio? newValue) {
                          setState(() {
                            widget.colloquio?.tipologiaColloquio.target = newValue;
                          });
                        },
                        items: tipoColloquio.map((TipologiaColloquio tipologiaColloquio) {
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
                        maxLines: null,
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
                        maxLines: null,
                        decoration:const InputDecoration(
                            labelText: "Agenzia"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     if (widget.colloquio?.commentoAgenzia == null){
                        //       return 'Please enter some text';
                        //     }
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          widget.colloquio?.commentoAgenzia = text;
                        },
                        initialValue: widget.colloquio?.commentoAgenzia,
                      ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Cliente"
                        ),
                        // validator:  (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter some text';
                        //   }
                        //   return null;
                        // },
                        onChanged: (text) {
                          widget.colloquio?.commentoCliente = text;
                        },
                        initialValue: widget.colloquio?.commentoCliente,
                      ),
                    ])
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "Salva",
          onPressed:(widget.anagrafica==null)?null:() async {
            if (_formKey.currentState!.validate()) {
              if (widget.colloquio != null) {
                widget.anagrafica?.colloqui.add(widget.colloquio??Colloquio());
              }
              Navigator.pop(context);
              // final value = await Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ColloquiAnagraficaList(anagrafica:widget.anagrafica??Anagrafica())));

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