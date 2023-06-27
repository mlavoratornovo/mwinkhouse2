import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mwinkhouse2/objbox/models/ClasseEnergetica.dart';
import 'package:mwinkhouse2/objbox/models/Colloquio.dart';
import 'package:mwinkhouse2/objbox/models/Comune.dart';
import 'package:mwinkhouse2/objbox/models/Contatto.dart';
import 'package:mwinkhouse2/objbox/models/Immobile.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Riscaldamento.dart';
import 'package:mwinkhouse2/objbox/models/StanzaImmobile.dart';
import 'package:mwinkhouse2/objbox/models/StatoConservativo.dart';
import 'package:mwinkhouse2/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_immagini_immobile.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_stanze_immobile.dart';

import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/Anagrafica.dart';
import '../../objbox/models/TipologiaColloquio.dart';
import '../../objbox/models/TipologiaStanza.dart';
import '../anagrafiche/lista_anagrafiche_proprieta.dart';
import 'lista_colloqui_immobile.dart';
import 'lista_comuni_ricerca.dart';

class DettaglioImmobile extends StatefulWidget {
  final String title = 'Dettaglio immobile';
  Immobile immobile;
  Immobile dbimm = new Immobile();
  bool bindRest;
  bool readonly;
  bool immobileIsFromDB = true;
  int spacecounter=0;
  List<TipologiaImmobile> tipologieImmobile = [];
  List<StatoConservativo> statoConservativo = [];
  List<ClasseEnergetica> classeEnergetica = [];
  List<Riscaldamento> riscaldamento = [];
  List<TipologiaStanza> tipologiaStanza = [];
  List<TipologiaColloquio> tipoColloquio = [];

  DettaglioImmobile({Key? key, required this.immobile, this.readonly=false, this.bindRest=false}) : super(key: key){
    tipologieImmobile = objectbox.tipologiaImmobileBox.getAll();
    statoConservativo = objectbox.statoConservativoBox.getAll();
    classeEnergetica = objectbox.classeEnergeticaBox.getAll();
    riscaldamento = objectbox.riscaldamentoBox.getAll();
    tipologiaStanza = objectbox.tipologiaStanzaBox.getAll();
    tipoColloquio = objectbox.tipologiaColloquioBox.getAll();
    if (bindRest){
      _bindRest();
      immobileIsFromDB = false;
    }
  }

  void _bindRest(){
    if (immobile.codImmobile != null){
      dbimm = objectbox.getImmobileByRif(immobile.rif??"")!;

      //immobile.codImmobile = null;
      bool findti = false;
      for(TipologiaImmobile tipo in tipologieImmobile){
        if (immobile.tipologiaImmobile.target?.descrizione?.toLowerCase() == tipo.descrizione?.toLowerCase()){
          immobile.tipologiaImmobile.target = tipo;
          findti = true;
          break;
        }
      }
      if (findti == false){
        immobile.tipologiaImmobile.target = null;
      }

      bool findsc = false;
      for(StatoConservativo stato in statoConservativo){
        if (immobile.statoConservativo.target?.descrizione?.toLowerCase() == stato.descrizione?.toLowerCase()){
          immobile.statoConservativo.target = stato;
          findsc = true;
          break;
        }
      }
      if (findsc == false){
        immobile.statoConservativo.target = null;
      }

      bool findr = false;
      for(Riscaldamento riscaldamento in riscaldamento){
        if (immobile.riscaldamento.target?.descrizione?.toLowerCase() == riscaldamento.descrizione?.toLowerCase()){
          immobile.riscaldamento.target = riscaldamento;
          findr = true;
          break;
        }
      }
      if (findr == false){
        immobile.riscaldamento.target = null;
      }

      bool findce = false;
      for(ClasseEnergetica classe in classeEnergetica){
        if (immobile.classeEnergetica.target?.nome?.toLowerCase() == classe.nome?.toLowerCase()){
          immobile.classeEnergetica.target = classe;
          findce = true;
          break;
        }
      }
      if (findce == false){
        immobile.classeEnergetica.target = null;
      }

      var stanzeiterator = immobile.stanze.iterator;
      while (stanzeiterator.moveNext()) {
        bool findts = false;
        for (TipologiaStanza tipostanza in tipologiaStanza) {
          if (stanzeiterator.current.tipologiaStanza.target
              ?.descrizione?.toLowerCase() == tipostanza.descrizione?.toLowerCase()) {
            stanzeiterator.current.tipologiaStanza.target = tipostanza;
            findts = true;
            break;
          }
        }
        if (findts == false){
          stanzeiterator.current.tipologiaStanza.target = null;
        }
      }

      var colloquioiterator = immobile.colloqui.iterator;
      while (colloquioiterator.moveNext()) {
        bool findts = false;
        for (TipologiaColloquio tipoc in tipoColloquio) {
          if (colloquioiterator.current.tipologiaColloquio.target
              ?.descrizione?.toLowerCase() == tipoc.descrizione?.toLowerCase()) {
            colloquioiterator.current.tipologiaColloquio.target = tipoc;
            findts = true;
            break;
          }
        }
        if (findts == false){
          colloquioiterator.current.tipologiaColloquio.target = null;
        }
      }
    }
  }

  @override
  State<DettaglioImmobile> createState() => _DettaglioImmobileState();
}

class _DettaglioImmobileState extends State<DettaglioImmobile> {


  final _formKey = GlobalKey<FormState>();

  _DettaglioImmobileState(){}

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
              PopupMenuItem(value: 0, child: Text('Stanze')),
              PopupMenuItem(value: 1, child: Text('Propietari')),
              PopupMenuItem(value: 2, child: Text('Immagini')),
              PopupMenuItem(value: 3, child: Text('Colloqui')),
              PopupMenuItem(value: 4, child: Text('Mappa')),
            ],
              onSelected: (result) {
                if (result == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StanzeImmobileList(immobile:widget.immobile??Immobile())),
                  );
                }
                if (result == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnagraficheProprietaList(immobile:widget.immobile??Immobile())),
                  );
                }
                if (result == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImmaginiImmobiliList(immobile:widget.immobile??Immobile())),
                  );
                }
                if (result == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColloquiImmobileList(immobile:widget.immobile??Immobile())),
                  );
                }
                if (result == 4){
                  MapsLauncher.launchQuery("${(widget.immobile?.indirizzo??'')}, ${(widget.immobile?.citta??'')}, ${(widget.immobile?.provincia??'')} ${(widget.immobile?.cap??'')}");
                }
              },
            )]),
    body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: (widget.immobileIsFromDB==true)?Colors.black:Colors.blue),
                key: Key("origine:${(widget.immobileIsFromDB==true)?"base dati locale": "base dati remota"}"),
                initialValue: "origine:${(widget.immobileIsFromDB==true)?"base dati locale": "base dati remota"}",
                enabled: false,

              ),
              TextFormField(
                decoration:const InputDecoration(
                  prefixIcon: Icon(Icons.key),
                    labelText: "Codice riferimento"
                ),
                validator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Codice riferimento dato obbligatorio';
                  }else{
                    Immobile? i = objectbox.getImmobileByRif(value);
                    if ( i != null && i.codImmobile != widget.immobile.codImmobile){
                      return 'Codice riferimento presente in archivio';
                    }
                  }
                  return null;
                },
                onChanged: (text) {
                  widget.immobile?.rif = text;
                },
                key: Key("${(widget.immobile.rif != null && widget.immobile.rif != '')? widget.immobile.rif:Random().nextInt(1000).toString()}"),
                initialValue: widget.immobile.rif ?? "",
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
                        widget.immobile?.provincia = text;
                      },
                      key: Key("${(widget.immobile.provincia != null && widget.immobile.provincia != '')? widget.immobile.provincia:Random().nextInt(1000).toString()}"),
                      initialValue: "${widget.immobile.provincia ?? ""}",
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
                        widget.immobile.cap = text;
                      },
                      key: Key("${(widget.immobile.cap != null && widget.immobile.cap != '')? widget.immobile.cap:Random().nextInt(1000).toString()}"),
                      initialValue: widget.immobile.cap ?? "",
                    ),
                  ),
                ],
              ),
              InkWell(
                onLongPress: () async {
                  final value = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListaComuniRicerca(immobile:widget.immobile)
                  )
                  );
                  setState(() {});
                },
                child: IgnorePointer(
                  ignoring: true,  // You can make this a variable in other toggle True or False
                  child: TextFormField(
                    decoration:const InputDecoration(
                        labelText: "Città"
                    ),
                    validator:  (value) {
                      if (value == null || value.isEmpty) {
                        return 'Città dato obbligatorio';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      widget.immobile.citta = text;
                    },
                    key: Key("${(widget.immobile.citta != null && widget.immobile.citta != '')? widget.immobile.citta:Random().nextInt(1000).toString()}"),
                    initialValue: "${widget.immobile.citta ?? ""}",
                  ),

                ),
              ),

              // TextFormField(
              //   decoration:const InputDecoration(
              //       labelText: "Città"
              //   ),
              //   validator:  (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Città dato obbligatorio';
              //     }
              //     return null;
              //   },
              //   onChanged: (text) {
              //     widget.immobile.citta = text;
              //   },
              //   key: Key("${(widget.immobile.citta != null && widget.immobile.citta != '')? widget.immobile.citta:Random().nextInt(1000).toString()}"),
              //   initialValue: "${widget.immobile.citta ?? ""}",
              // ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Zona"
                ),
                onChanged: (text) {
                  widget.immobile.zona = text;
                },
                key: Key("${(widget.immobile.zona != null && widget.immobile.zona != '')? widget.immobile.zona:Random().nextInt(1000).toString()}"),
                initialValue: widget.immobile.zona ?? "",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Indirizzo"
                ),
                validator:  (value) {
                  if (value == null || value.isEmpty) {
                    return 'Indirizzo dato obbligatorio';
                  }
                  return null;
                },
                onChanged: (text) {
                  widget.immobile?.indirizzo = text;
                },
                key: Key("${(widget.immobile.indirizzo != null && widget.immobile.indirizzo != '')? widget.immobile.indirizzo:Random().nextInt(1000).toString()}"),
                initialValue: widget.immobile?.indirizzo ?? "",
              ),
              TextFormField(
                decoration:const InputDecoration(
                    labelText: "Prezzo"
                ),
                onChanged: (text) {
                  widget.immobile?.prezzo = double.parse(text);
                },
                key: Key("${(widget.immobile.prezzo != null && widget.immobile.prezzo != 0)? widget.immobile.prezzo:Random().nextInt(1000).toString()}"),
                initialValue: "${widget.immobile?.prezzo ?? ""}",
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
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
                          labelText: "Mq"
                      ),
                      onChanged: (text) {
                        widget.immobile?.mq = int.parse(text);
                      },
                      key: Key("${(widget.immobile.mq != null && widget.immobile.mq != 0)? widget.immobile.mq:Random().nextInt(1000).toString()}"),
                      initialValue: "${widget.immobile?.mq ?? ""}",
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
                          labelText: "Anno Costruzione"
                      ),
                      onChanged: (text) {
                        widget.immobile?.annoCostruzione = int.parse(text);
                      },
                      key: Key("${(widget.immobile.annoCostruzione != null && widget.immobile.annoCostruzione != 0)? widget.immobile.annoCostruzione:Random().nextInt(1000).toString()}"),
                      initialValue: "${widget.immobile?.annoCostruzione ?? ""}",
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              TextFormField(
                maxLines: null,
                decoration:const InputDecoration(
                    labelText: "descrizione"
                ),
                onChanged: (text) {
                  widget.immobile?.descrizione = text;
                },
                key: Key("${(widget.immobile.descrizione != null && widget.immobile.descrizione != '')? widget.immobile.descrizione:Random().nextInt(1000).toString()}"),
                initialValue: widget.immobile?.descrizione ?? "",
              ),
              DropdownButtonFormField<TipologiaImmobile>(
                isExpanded: true,
                hint: const Text('Tipologia immobile'),
                // validator: (value) => value == null ? 'Tipologia dato obbligatorio' : null,
                value: widget.immobile?.tipologiaImmobile?.target,
                onChanged: (TipologiaImmobile? newValue) {
                  setState(() {
                    widget.immobile?.tipologiaImmobile.target = newValue;
                  });
                },
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
                hint: const Text('Stato conservativo'),
                value: widget.immobile?.statoConservativo?.target,
                onChanged: (StatoConservativo? newValue) {
                  setState(() {
                    widget.immobile?.statoConservativo.target = newValue;
                  });
                },
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
                hint: const Text('Class energetica'),
                value: widget.immobile?.classeEnergetica?.target,
                onChanged: (ClasseEnergetica? newValue) {
                  setState(() {
                    widget.immobile?.classeEnergetica.target = newValue;
                  });
                },
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
                hint: const Text('Riscaldamento'),
                value: widget.immobile?.riscaldamento?.target,
                onChanged: (Riscaldamento? newValue) {
                  setState(() {
                    widget.immobile?.riscaldamento.target = newValue;
                  });
                },
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
      children: [
        FloatingActionButton(
          heroTag: "Salva",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.bindRest == true){
                widget.immobile.codImmobile = null;
                Iterator<Anagrafica> ita = widget.immobile.proprietari.iterator;
                while(ita.moveNext()){
                  ita.current.codAnagrafica = null;
                  Iterator<Contatto> itco = ita.current.contatti.iterator;
                  while(itco.moveNext()){
                    itco.current.codAnagrafica = null;
                    itco.current.codContatto = null;
                  }
                }
                Iterator<Colloquio> itc = widget.immobile.colloqui.iterator;
                while(itc.moveNext()){
                  itc.current.codColloquio = null;
                }
                Iterator<StanzaImmobile> its = widget.immobile.stanze.iterator;
                while(its.moveNext()){
                  its.current.codImmobile = null;
                  its.current.codStanzaImmobile = null;
                }
              }
              objectbox.addImmobile(widget.immobile ?? Immobile());
              Navigator.pop(context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dati non validi impossibile procedere')),
              );
            }
          },
          child: const Icon(Icons.save),
        ),
        FloatingActionButton(
          heroTag: "Switch",
          backgroundColor: (widget.dbimm.codImmobile != null)?null:Colors.grey,
          onPressed: (widget.dbimm.codImmobile != null) ? () {

            widget.immobileIsFromDB=!widget.immobileIsFromDB;

            Immobile tmp=widget.immobile;
            widget.immobile = widget.dbimm;
            widget.dbimm = tmp;

            setState(() {});
          }:null,
          child: const Icon(Icons.switch_account),
        ),

      ])
    );
  }


}