import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse/main.dart';
import 'package:mwinkhouse/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili_ricerca_rest.dart';

import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/CriteriRicercaImmobile.dart';

class CriteriRicercaImmobileEditorRest extends StatefulWidget {
  final String title = 'Ricerca remota';
  final CriteriRicercaImmobile criteri = CriteriRicercaImmobile();
  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];
  late WinkhouseRest winkhouseRest;
  bool validConnection = false;
  CriteriRicercaImmobileEditorRest({super.key}){
    createState();
    winkhouseRest = WinkhouseRest();
  }



  @override
  State<CriteriRicercaImmobileEditorRest> createState() => _CriteriRicercaImmobileEditorState();
}

class _CriteriRicercaImmobileEditorState extends State<CriteriRicercaImmobileEditorRest> {


  final _formKey = GlobalKey<FormState>();

  _CriteriRicercaImmobileEditorState(){
    // fillcombo();
  }

  Future<void> fillcombo() async {

      widget.winkhouseRest.getTipologieImmobili().then((value) =>  setState(() {widget.tipologieImmobile = value;}));
      widget.winkhouseRest.getStatoConservativo().then((value) => setState(() {widget.statoConservativo = value;}));
      widget.winkhouseRest.getClasseEnergetica().then((value) => setState(() {widget.classeEnergetica = value;}));
      widget.winkhouseRest.getRiscaldamento().then((value) => setState(() {widget.riscaldamento = value;}));

  }

  Future<void> checkcon() async {

    widget.winkhouseRest.getTipologieImmobili()
        .then((value) =>  setState(() {widget.validConnection = true;}))
        .catchError((error, stack){
      widget.validConnection = false;
    });

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
                        builder: (context) => const MyHomePage(title: 'Winkhouse 2.0.1',)
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
        body: Container(
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
                          const SizedBox(width: 10.0),
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
                      // TextFormField(
                      //   decoration:const InputDecoration(
                      //       labelText: "Zona"
                      //   ),
                      //   onChanged: (text) {
                      //     widget.criteri.zona = text;
                      //   },
                      // ),
                      TextFormField(
                        decoration:const InputDecoration(
                            labelText: "Indirizzo"
                        ),
                        onChanged: (text) {
                          widget.criteri.indirizzo = text;
                        },
                      ),
                      // DropdownButton<TipologiaImmobile>(
                      //   isExpanded: true,
                      //   hint: Text('Tipologia immobile'),
                      //   onChanged: (TipologiaImmobile? newValue) {
                      //     setState(() {
                      //       widget.criteri.tipologiaImmobile = newValue;
                      //     });
                      //   },
                      //   value: widget.criteri.tipologiaImmobile,
                      //   items: widget.tipologieImmobile.map((TipologiaImmobile tipologiaImmobile) {
                      //     return DropdownMenuItem<TipologiaImmobile>(
                      //       value: tipologiaImmobile,
                      //       child: Text(
                      //         tipologiaImmobile.descrizione??"",
                      //         style: const TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // DropdownButton<StatoConservativo>(
                      //   isExpanded: true,
                      //   hint: Text('Stato conservativo'),
                      //   onChanged: (StatoConservativo? newValue) {
                      //     setState(() {
                      //       widget.criteri.statoConservativo = newValue;
                      //     });
                      //   },
                      //   value: widget.criteri.statoConservativo,
                      //   items: widget.statoConservativo.map((StatoConservativo statoConservativo) {
                      //     return DropdownMenuItem<StatoConservativo>(
                      //       value: statoConservativo,
                      //       child: Text(
                      //         statoConservativo.descrizione??"",
                      //         style: const TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // DropdownButton<ClasseEnergetica>(
                      //   isExpanded: true,
                      //   hint: Text('Class energetica'),
                      //   onChanged: (ClasseEnergetica? newValue) {
                      //     setState(() {
                      //       widget.criteri.classeEnergetica = newValue;
                      //     });
                      //   },
                      //   value: widget.criteri.classeEnergetica,
                      //   items: widget.classeEnergetica.map((ClasseEnergetica classeEnergetica) {
                      //     return DropdownMenuItem<ClasseEnergetica>(
                      //       value: classeEnergetica,
                      //       child: Text(
                      //         classeEnergetica.nome??"",
                      //         style: const TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // DropdownButton<Riscaldamento>(
                      //   isExpanded: true,
                      //   hint: Text('Riscaldamento'),
                      //   onChanged: (Riscaldamento? newValue) {
                      //     setState(() {
                      //       widget.criteri.riscaldamento = newValue;
                      //     });
                      //   },
                      //   value: widget.criteri.riscaldamento,
                      //   items: widget.riscaldamento.map((Riscaldamento riscaldamento) {
                      //     return DropdownMenuItem<Riscaldamento>(
                      //       value: riscaldamento,
                      //       child: Text(
                      //         riscaldamento.descrizione??"",
                      //         style: const TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                    ])
            ),
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "CercaRest",
              onPressed: () {
                if (widget.validConnection == true){
                  if ((widget.criteri.provincia.trim() != '') ||
                      (widget.criteri.cap.trim() != '') ||
                      (widget.criteri.citta.trim() != '') ||
                      // (widget.criteri.zona.trim() != '') ||
                      (widget.criteri.indirizzo.trim() != '')
                  // (widget.criteri.classeEnergetica != null) || (widget.criteri.riscaldamento != null) ||
                  // (widget.criteri.tipologiaImmobile != null) || (widget.criteri.statoConservativo != null)
                  ) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImmobiliRicercaRestList(criteri:widget.criteri)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Dati non validi impossibile procedere')),
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Impossibile connettersi a winkhouse controllare le impostazioni')),
                  );
                }
              },
              child: const Icon(Icons.network_wifi_sharp),
            ),
            FloatingActionButton(
              heroTag: "Reset",
              onPressed: () {
                widget.criteri.resetData();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => CriteriRicercaImmobileEditorRest(),
                  ),
                );          },
              child: const Icon(Icons.cleaning_services_outlined),
            )        ])
    );
  }


}