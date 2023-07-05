import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import '../../main.dart';
import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/ClasseCliente.dart';
import '../../objbox/models/ClasseEnergetica.dart';
import '../../objbox/models/Riscaldamento.dart';
import '../../objbox/models/StatoConservativo.dart';
import '../../objbox/models/TipologiaContatto.dart';
import '../../objbox/models/TipologiaImmobile.dart';
import '../../objbox/models/TipologiaStanza.dart';

class BaseData extends StatefulWidget {

  final String title = 'Categorie';
  final Icon addIcon = const Icon(Icons.add_box_outlined,color: Colors.white);
  final Icon editIcon = const Icon(Icons.edit_outlined,color: Colors.white);
  final Icon deleteIcon = const Icon(Icons.delete_outline_outlined,color: Colors.white);
  final Icon saveIcon = const Icon(Icons.save_outlined,color: Colors.white);
  final Icon syncIcon = const Icon(Icons.screen_rotation_alt_outlined,color: Colors.white);

  late WinkhouseRest winkhouseRest;
  bool validConnection = false;

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
    winkhouseRest = WinkhouseRest();
  }

  @override
  State<BaseData> createState() => _BaseDataState();
}

class _BaseDataState extends State<BaseData> {

  final _formKey = GlobalKey<FormState>();

  _BaseDataState();

  Future<void> checkcon() async {

    widget.winkhouseRest.getTipologieImmobili()
        .then((value) =>  setState(() {widget.validConnection = true;}))
        .catchError((error, stack){
      widget.validConnection = false;
    });

  }

  Future<dynamic> _openPopUp(BuildContext context, String type) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: ((type=='ClasseEnergetica')?200:110),
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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
      );

    }
    if (type == 'ClasseEnergetica'){
      widgets.add(
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Nome classe energetica"
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
          TextFormField(
            decoration:const InputDecoration(
                labelText: "Descrizione classe energetica"
            ),
            validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Inserire la descrizione';
              }
              return null;
            },
            onChanged: (text) {
              widget.classeEnergeticaSelected?.descrizione = text;
            },
            initialValue: "${(widget.classeEnergeticaSelected?.descrizione == null)?"":widget.classeEnergeticaSelected?.descrizione}",
          )
      );
      widgets.add(
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),

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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
      );
    }
    if (type == 'TipologiaContatto'){
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
              backgroundColor: Colors.blue,
              shape: CircleBorder(),
            ),
            child: widget.saveIcon,
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
          ),
      );

    }
    return widgets;
  }

  Future<void> _syncData(BuildContext context, String type) async {
    if (widget.validConnection == true){
      int dataMode = Settings.getValue<int>("baseDataMergeMode", 0);
      switch(type){
        case 'TipologiaImmobile':
          List<TipologiaImmobile> winkTipologieImmobili = await widget.winkhouseRest.getTipologieImmobili();
          switch(dataMode) {
            case 0:
              for (final e in winkTipologieImmobili){
                e.codTipologiaImmobile = null;
              }
              objectbox.tipologiaImmobileBox.putMany(winkTipologieImmobili);
              setState(() {
                widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
              });
              break;
            case 1:
              List<TipologiaImmobile> obTipologieImmobili = objectbox.tipologiaImmobileBox.getAll();
              for(final e in winkTipologieImmobili){
                try {
                  TipologiaImmobile ti = obTipologieImmobili.firstWhere((
                      element) =>
                  element.codTipologiaImmobile == e.codTipologiaImmobile);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codTipologiaImmobile = null;
                  obTipologieImmobili.add(e);
                }
              }
              objectbox.tipologiaImmobileBox.putMany(obTipologieImmobili);
              setState(() {
                widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
              });
              break;
            case 2:
              List<TipologiaImmobile> obTipologieImmobili = objectbox.tipologiaImmobileBox.getAll();
              for(final e in winkTipologieImmobili){
                try {
                  TipologiaImmobile ti = obTipologieImmobili.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codTipologiaImmobile = null;
                  obTipologieImmobili.add(e);
                }
              }
              objectbox.tipologiaImmobileBox.putMany(obTipologieImmobili);
              setState(() {
                widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
              });
              break;
            case 3:
              for (final e in winkTipologieImmobili){
                e.codTipologiaImmobile = null;
              }
              objectbox.tipologiaImmobileBox.removeAll();
              objectbox.tipologiaImmobileBox.putMany(winkTipologieImmobili);
              setState(() {
                widget.tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
              });
              break;
          }
          break;
        case 'StatoConservativo':
          List<StatoConservativo> winkStatoConservativo = await widget.winkhouseRest.getStatoConservativo();
          switch(dataMode) {
            case 0:
              for (final e in winkStatoConservativo){
                e.codStatoConservativo = null;
              }
              objectbox.statoConservativoBox.putMany(winkStatoConservativo);
              setState(() {
                widget.statoConservativo = objectbox.statoConservativoBox.getAll();
              });
              break;
            case 1:
              List<StatoConservativo> obStatoConservativo = objectbox.statoConservativoBox.getAll();
              for(final e in winkStatoConservativo){
                try {
                  StatoConservativo ti = obStatoConservativo.firstWhere((
                      element) =>
                  element.codStatoConservativo == e.codStatoConservativo);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codStatoConservativo = null;
                  obStatoConservativo.add(e);
                }
              }
              objectbox.statoConservativoBox.putMany(obStatoConservativo);
              setState(() {
                widget.statoConservativo = objectbox.statoConservativoBox.getAll();
              });
              break;
            case 2:
              List<StatoConservativo> obStatoConservativo = objectbox.statoConservativoBox.getAll();
              for(final e in winkStatoConservativo){
                try {
                  StatoConservativo ti = obStatoConservativo.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codStatoConservativo = null;
                  obStatoConservativo.add(e);
                }
              }
              objectbox.statoConservativoBox.putMany(obStatoConservativo);
              setState(() {
                widget.statoConservativo = objectbox.statoConservativoBox.getAll();
              });
              break;
            case 3:
              for (final e in winkStatoConservativo){
                e.codStatoConservativo = null;
              }
              objectbox.statoConservativoBox.removeAll();
              objectbox.statoConservativoBox.putMany(winkStatoConservativo);
              setState(() {
                widget.statoConservativo = objectbox.statoConservativoBox.getAll();
              });
              break;
          }
          break;
        case 'ClasseEnergetica':
          List<ClasseEnergetica> winkClasseEnergetica = await widget.winkhouseRest.getClasseEnergetica();
          switch(dataMode) {
            case 0:
              for (final e in winkClasseEnergetica){
                e.codClasseEnergetica = null;
              }
              objectbox.classeEnergeticaBox.putMany(winkClasseEnergetica);
              setState(() {
                widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
              });
              break;
            case 1:
              List<ClasseEnergetica> obClasseEnergetica = objectbox.classeEnergeticaBox.getAll();
              for(final e in winkClasseEnergetica){
                try {
                  ClasseEnergetica ti = obClasseEnergetica.firstWhere((
                      element) =>
                  element.codClasseEnergetica == e.codClasseEnergetica);
                  ti.descrizione = e.descrizione;
                  ti.nome = e.nome;
                }on StateError {
                  e.codClasseEnergetica = null;
                  obClasseEnergetica.add(e);
                }
              }
              objectbox.classeEnergeticaBox.putMany(obClasseEnergetica);
              setState(() {
                widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
              });
              break;
            case 2:
              List<ClasseEnergetica> obClasseEnergetica = objectbox.classeEnergeticaBox.getAll();
              for(final e in winkClasseEnergetica){
                try {
                  ClasseEnergetica ti = obClasseEnergetica.firstWhere((
                      element) =>
                  element.nome == e.nome);
                }on StateError {
                  e.codClasseEnergetica = null;
                  obClasseEnergetica.add(e);
                }
              }
              objectbox.classeEnergeticaBox.putMany(obClasseEnergetica);
              setState(() {
                widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
              });
              break;
            case 3:
              for (final e in winkClasseEnergetica){
                e.codClasseEnergetica = null;
              }
              objectbox.classeEnergeticaBox.removeAll();
              objectbox.classeEnergeticaBox.putMany(winkClasseEnergetica);
              setState(() {
                widget.classeEnergetica = objectbox.classeEnergeticaBox.getAll();
              });
              break;
          }
          break;
        case 'Riscaldamento':
          List<Riscaldamento> winkRiscaldamento = await widget.winkhouseRest.getRiscaldamento();
          switch(dataMode) {
            case 0:
              for (final e in winkRiscaldamento){
                e.codRiscaldamento = null;
              }
              objectbox.riscaldamentoBox.putMany(winkRiscaldamento);
              setState(() {
                setState(() {
                  widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
                });
              });
              break;
            case 1:
              List<Riscaldamento> obRiscaldamento = objectbox.riscaldamentoBox.getAll();
              for(final e in winkRiscaldamento){
                try {
                  Riscaldamento ti = obRiscaldamento.firstWhere((
                      element) =>
                  element.codRiscaldamento == e.codRiscaldamento);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codRiscaldamento = null;
                  obRiscaldamento.add(e);
                }
              }
              objectbox.riscaldamentoBox.putMany(obRiscaldamento);
              setState(() {
                widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
              });
              break;
            case 2:
              List<Riscaldamento> obRiscaldamento = objectbox.riscaldamentoBox.getAll();
              for(final e in winkRiscaldamento){
                try {
                  Riscaldamento ti = obRiscaldamento.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codRiscaldamento = null;
                  obRiscaldamento.add(e);
                }
              }
              objectbox.riscaldamentoBox.putMany(obRiscaldamento);
              setState(() {
                widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
              });
              break;
            case 3:
              for (final e in winkRiscaldamento){
                e.codRiscaldamento = null;
              }
              objectbox.riscaldamentoBox.removeAll();
              objectbox.riscaldamentoBox.putMany(winkRiscaldamento);
              setState(() {
                widget.riscaldamento = objectbox.riscaldamentoBox.getAll();
              });
              break;
          }
          break;
        case 'TipologiaStanza':
          List<TipologiaStanza> winkTipologiaStanza = await widget.winkhouseRest.getTipologiaStanza();
          switch(dataMode) {
            case 0:
              for (final e in winkTipologiaStanza){
                e.codTipologiaStanza = null;
              }
              objectbox.tipologiaStanzaBox.putMany(winkTipologiaStanza);
              setState(() {
                widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              });
              break;
            case 1:
              List<TipologiaStanza> obTipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              for(final e in winkTipologiaStanza){
                try {
                  TipologiaStanza ti = obTipologiaStanza.firstWhere((
                      element) =>
                  element.codTipologiaStanza == e.codTipologiaStanza);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codTipologiaStanza = null;
                  obTipologiaStanza.add(e);
                }
              }
              objectbox.tipologiaStanzaBox.putMany(obTipologiaStanza);
              setState(() {
                widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              });
              break;
            case 2:
              List<TipologiaStanza> obTipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              for(final e in winkTipologiaStanza){
                try {
                  TipologiaStanza ti = obTipologiaStanza.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codTipologiaStanza = null;
                  obTipologiaStanza.add(e);
                }
              }
              objectbox.tipologiaStanzaBox.putMany(obTipologiaStanza);
              setState(() {
                widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              });
              break;
            case 3:
              for (final e in winkTipologiaStanza){
                e.codTipologiaStanza = null;
              }
              objectbox.tipologiaStanzaBox.removeAll();
              objectbox.tipologiaStanzaBox.putMany(winkTipologiaStanza);
              setState(() {
                widget.tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
              });
              break;
          }
          break;
        case 'ClasseCliente':
          List<ClasseCliente> winkClasseCliente = await widget.winkhouseRest.getClassiClienti();
          switch(dataMode) {
            case 0:
              for (final e in winkClasseCliente){
                e.codClasseCliente = null;
              }
              objectbox.classeClienteBox.putMany(winkClasseCliente);
              setState(() {
                widget.classeCliente = objectbox.classeClienteBox.getAll();
              });
              break;
            case 1:
              List<ClasseCliente> obClasseCliente = objectbox.classeClienteBox.getAll();
              for(final e in winkClasseCliente){
                try {
                  ClasseCliente ti = obClasseCliente.firstWhere((
                      element) =>
                  element.codClasseCliente == e.codClasseCliente);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codClasseCliente = null;
                  obClasseCliente.add(e);
                }
              }
              objectbox.classeClienteBox.putMany(obClasseCliente);
              setState(() {
                widget.classeCliente = objectbox.classeClienteBox.getAll();
              });
              break;
            case 2:
              List<ClasseCliente> obClasseCliente = objectbox.classeClienteBox.getAll();
              for(final e in winkClasseCliente){
                try {
                  ClasseCliente ti = obClasseCliente.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codClasseCliente = null;
                  obClasseCliente.add(e);
                }
              }
              objectbox.classeClienteBox.putMany(obClasseCliente);
              setState(() {
                widget.classeCliente = objectbox.classeClienteBox.getAll();
              });
              break;
            case 3:
              for (final e in winkClasseCliente){
                e.codClasseCliente = null;
              }
              objectbox.classeClienteBox.removeAll();
              objectbox.classeClienteBox.putMany(winkClasseCliente);
              setState(() {
                widget.classeCliente = objectbox.classeClienteBox.getAll();
              });
              break;
          }
          break;
        case 'TipologiaContatto':
          List<TipologiaContatto> winkTipologiaContatto = await widget.winkhouseRest.getTipologiaContatto();
          switch(dataMode) {
            case 0:
              for (final e in winkTipologiaContatto){
                e.codTipologiaContatto = null;
              }
              objectbox.tipologiaContattoBox.putMany(winkTipologiaContatto);
              setState(() {
                widget.tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              });
              break;
            case 1:
              List<TipologiaContatto> obTipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              for(final e in winkTipologiaContatto){
                try {
                  TipologiaContatto ti = obTipologiaContatto.firstWhere((
                      element) =>
                  element.codTipologiaContatto == e.codTipologiaContatto);
                  ti.descrizione = e.descrizione;
                }on StateError {
                  e.codTipologiaContatto = null;
                  obTipologiaContatto.add(e);
                }
              }
              objectbox.tipologiaContattoBox.putMany(obTipologiaContatto);
              setState(() {
                widget.tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              });
              break;
            case 2:
              List<TipologiaContatto> obTipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              for(final e in winkTipologiaContatto){
                try {
                  TipologiaContatto ti = obTipologiaContatto.firstWhere((
                      element) =>
                  element.descrizione == e.descrizione);
                }on StateError {
                  e.codTipologiaContatto = null;
                  obTipologiaContatto.add(e);
                }
              }
              objectbox.tipologiaContattoBox.putMany(obTipologiaContatto);
              setState(() {
                widget.tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              });
              break;
            case 3:
              for (final e in winkTipologiaContatto){
                e.codTipologiaContatto = null;
              }
              objectbox.tipologiaContattoBox.removeAll();
              objectbox.tipologiaContattoBox.putMany(winkTipologiaContatto);
              setState(() {
                widget.tipologiaContatto = objectbox.tipologiaContattoBox.getAll();
              });
              break;
          }
          break;
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossibile connettersi a winkhouse controllare le impostazioni')),
      );
    }
  }

  @override
  void initState() {
    checkcon();
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
                Text(widget.title)]
          ),

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
                                  hint: const Text('Tipologie immobili'),
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
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: CircleBorder(),
                                          ),
                                          child: widget.addIcon,
                                          onPressed: () {
                                            widget.tipologieImmobileSelected = TipologiaImmobile();
                                            _openPopUp(context,'TipologiaImmobile');
                                          },
                                        ),
                                    ),
                                    Expanded(
                                        child:TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: CircleBorder(),
                                          ),
                                          child: widget.editIcon,
                                          onPressed: () {
                                            if (widget.tipologieImmobileSelected != null){
                                              _openPopUp(context,'TipologiaImmobile');
                                            }else{
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Selezionare lo tipologia')),
                                              );
                                            }
                                          },
                                        ),
                                    ),
                                    Expanded(
                                      child:TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: CircleBorder(),
                                        ),
                                        child: widget.deleteIcon,
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
                                        child:TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: CircleBorder(),
                                          ),
                                          child: widget.syncIcon,
                                          onPressed: () {
                                            _syncData(context, 'TipologiaImmobile')
                                               .whenComplete(() => {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Operazione eseguita'))
                                               )})
                                               .onError((error, stackTrace) => {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Operazione non eseguita'))
                                               )});
                                          },
                                        ),
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
                              hint: const Text('Stato Conservativo'),
                              isExpanded: true,
                              value: widget.statoConservativoSelected,
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.statoConservativoSelected = StatoConservativo();
                                        _openPopUp(context,'StatoConservativo');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.statoConservativoSelected != null){
                                        _openPopUp(context,'StatoConservativo');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare lo stato')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.syncIcon,
                                    onPressed: () {
                                      _syncData(context, 'StatoConservativo')
                                          .whenComplete(() => {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Operazione eseguita'))
                                        )})
                                          .onError((error, stackTrace) => {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Operazione non eseguita'))
                                        )});
                                    },
                                  ),
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
                              hint: const Text('Classe Energetica'),
                              isExpanded: true,
                              value: widget.classeEnergeticaSelected,
                              onChanged: (ClasseEnergetica? newValue) {
                                setState(() {
                                  widget.classeEnergeticaSelected = newValue;
                                });
                              },
                              items: widget.classeEnergetica.map((
                                  ClasseEnergetica classeEnergetica) {
                                return DropdownMenuItem<ClasseEnergetica>(
                                  value: classeEnergetica,
                                  child: Text('${classeEnergetica.nome ?? ''} - ${classeEnergetica.descrizione ?? ''}',
                                    style: const TextStyle(color: Colors.black),

                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.classeEnergeticaSelected = ClasseEnergetica();
                                        _openPopUp(context,'ClasseEnergetica');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.classeEnergeticaSelected != null){
                                        _openPopUp(context,'ClasseEnergetica');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la classe energetica')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.syncIcon,
                                      onPressed: () {
                                        _syncData(context, 'ClasseEnergetica')
                                            .whenComplete(() => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione eseguita'))
                                          )})
                                            .onError((error, stackTrace) => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione non eseguita'))
                                          )});
                                      },
                                    ),
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
                              hint: const Text('Riscaldamento'),
                              isExpanded: true,
                              value: widget.riscaldamentoSelected,
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.riscaldamentoSelected = Riscaldamento();
                                        _openPopUp(context,'Riscaldamento');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.riscaldamentoSelected != null){
                                        _openPopUp(context,'Riscaldamento');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare il riscaldamento')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.syncIcon,
                                      onPressed: () {
                                        _syncData(context, 'Riscaldamento')
                                            .whenComplete(() => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione eseguita'))
                                          )})
                                            .onError((error, stackTrace) => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione non eseguita'))
                                          )});
                                      },
                                    ),
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
                              hint: const Text('Tipologie stanze'),
                              isExpanded: true,
                              value: widget.tipologiaStanzaSelected,
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.tipologiaStanzaSelected = TipologiaStanza();
                                        _openPopUp(context,'TipologiaStanza');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.tipologiaStanzaSelected != null){
                                        _openPopUp(context,'TipologiaStanza');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la tipologia')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.syncIcon,
                                      onPressed: () {
                                        _syncData(context, 'TipologiaStanza')
                                            .whenComplete(() => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione eseguita'))
                                          )})
                                            .onError((error, stackTrace) => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione non eseguita'))
                                          )});
                                      },
                                    ),
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
                              hint: const Text('Categoria Cliente'),
                              isExpanded: true,
                              value:  widget.classeClienteSelected,
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.classeClienteSelected = ClasseCliente();
                                        _openPopUp(context, 'ClasseCliente');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.classeClienteSelected != null){
                                        _openPopUp(context, 'ClasseCliente');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare la categoria')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.syncIcon,
                                      onPressed: () {
                                        _syncData(context, 'ClasseCliente')
                                            .whenComplete(() => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione eseguita'))
                                          )})
                                            .onError((error, stackTrace) => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione non eseguita'))
                                          )});
                                      },
                                    ),
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
                              hint: const Text('Tipologia Contatto'),
                              isExpanded: true,
                              value: widget.tipologiaContattoSelected,
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
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.addIcon,
                                      onPressed: () {
                                        widget.tipologiaContattoSelected = TipologiaContatto();
                                        _openPopUp(context, 'TipologiaContatto');
                                      },
                                    ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.editIcon,
                                    onPressed: () {
                                      if (widget.tipologiaContattoSelected != null){
                                        _openPopUp(context,'TipologiaContatto');
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Selezionare lo tipologia')),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child:TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                    ),
                                    child: widget.deleteIcon,
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
                                    child:TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: CircleBorder(),
                                      ),
                                      child: widget.syncIcon,
                                      onPressed: () {
                                        _syncData(context, 'TipologiaContatto')
                                            .whenComplete(() => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione eseguita'))
                                          )})
                                            .onError((error, stackTrace) => {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Operazione non eseguita'))
                                          )});
                                      },
                                    ),
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