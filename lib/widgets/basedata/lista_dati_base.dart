import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/objbox/models/ClasseCliente.dart';
import 'package:mwinkhouse/objbox/models/IDatiBase.dart';
import 'package:mwinkhouse/objbox/models/TipologiaImmobile.dart';
import 'package:mwinkhouse/objbox/models/TipologiaStanza.dart';
import 'package:mwinkhouse/widgets/anagrafiche/dettaglio_anagrafica.dart';

import '../../main.dart';
import '../../objbox/models/ClasseEnergetica.dart';
import '../../objbox/models/Immobile.dart';
import '../../objbox/models/Riscaldamento.dart';
import '../../objbox/models/StatoConservativo.dart';
import '../../objbox/models/TipologiaContatto.dart';

enum BaseDatiType {
  tipiimmobili,
  statoconservativo,
  classeenergetica,
  riscaldamenti,
  tipistanza,
  tipiclienti,
  tipicontatti
}

/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class BaseDatiList extends StatefulWidget {

  final Icon addIcon = const Icon(Icons.add_box_outlined,color: Colors.white);
  final Icon editIcon = const Icon(Icons.edit_outlined,color: Colors.white);
  final Icon deleteIcon = const Icon(Icons.delete_outline_outlined,color: Colors.white);
  final Icon saveIcon = const Icon(Icons.save_outlined,color: Colors.white);
  final Icon syncIcon = const Icon(Icons.screen_rotation_alt_outlined,color: Colors.white);


  String title = '';
  BaseDatiType tipoDati = BaseDatiType.tipiimmobili;

  BaseDatiList({super.key, required this.tipoDati}){
    this.tipoDati = tipoDati;
    switch(tipoDati){
      case (BaseDatiType.tipiimmobili):
        title = "Tipologie immobile";
      case (BaseDatiType.tipiclienti):
        title = "Categorie cliente";
      case (BaseDatiType.classeenergetica):
        title = "Classi energetiche";
      case (BaseDatiType.riscaldamenti):
        title = "Riscaldamenti";
      case (BaseDatiType.statoconservativo):
        title = "Stati conservativi";
      case (BaseDatiType.tipicontatti):
        title = "Tipologie contatti";
      case (BaseDatiType.tipistanza):
        title = "Tipologie stanze";
    }
  }

  @override
  State<BaseDatiList> createState() => _BaseDatiListState(tipoDati);
}

extension SafeLookup<E> on List<E> {
  E? get(int index) {
    try {
      return this[index];
    } on RangeError {
      return null;
    }
  }
}

class _BaseDatiListState extends State<BaseDatiList> {

   BaseDatiType? tipoDati;
  _BaseDatiListState(this.tipoDati);

  final _formKey = GlobalKey<FormState>();
  Dismissible Function(BuildContext, int) _itemBuilder<T>(List<IDatiBase> datibase) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          removeDatiBase(datibase[index].getCodice());
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text(deleteMessage(datibase[index].getDescrizione()))
              )
          ));
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    border:
                    Border(bottom: BorderSide(color: Colors.black12))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${datibase[index].getNome()}',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                        // Provide a Key for the integration test
                        key: Key('list_item_$index'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          datibase[index].getDescrizione(),
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  _openPopUp(context, datibase[index]);
                }
                ),
          ],
        ),
      );


  @override
  Widget build(BuildContext context) {
    setState(() {
      this.tipoDati = tipoDati;
    });
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
                Text(widget.title)]
          ),

        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child:Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: StreamBuilder<List<IDatiBase>?>(
                          stream: getStreamData(),//(immobile!=null)?objectbox.getAnagrafiche(notin:idAnagrafiche):objectbox.getAnagrafiche(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              // Print the stack trace and show the error message.
                              // An actual app would display a user-friendly error message
                              // and report the error behind the scenes.
                              debugPrintStack(stackTrace: snapshot.stackTrace);
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 16, left: 16, right: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                                  itemBuilder: _itemBuilder(snapshot.data ?? []));
                            }
                          }
                      )
                  )
                ]
            )
          ),
        ),
        floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "Nuovo",
                onPressed:  (){_openPopUp(context, getNewDatiBase());},
                child: const Icon(Icons.add),
              )
            ]
        ));
  }

  IDatiBase getNewDatiBase(){
    switch(tipoDati){
      case (BaseDatiType.tipiimmobili):
        return TipologiaImmobile();
      case (BaseDatiType.tipiclienti):
        return ClasseCliente();
      case (BaseDatiType.classeenergetica):
        return ClasseEnergetica();
      case (BaseDatiType.riscaldamenti):
        return Riscaldamento();
      case (BaseDatiType.statoconservativo):
        return StatoConservativo();
      case (BaseDatiType.tipicontatti):
        return TipologiaContatto();
      case (BaseDatiType.tipistanza):
        return TipologiaStanza();
      case (null):
        showErrorDialog(context, 'Impossibile determinare il tipo di categoria');
        return TipologiaImmobile();
    }
  }

  Stream<List<IDatiBase>> getStreamData(){
    switch(tipoDati){
      case (BaseDatiType.tipiimmobili):
        return objectbox.getTipologiaImmobile();
      case (BaseDatiType.tipiclienti):
        return objectbox.getClassiCliente();
      case (BaseDatiType.classeenergetica):
        return objectbox.getClasseEnergetica();
      case (BaseDatiType.riscaldamenti):
        return objectbox.getRiscaldamenti();
      case (BaseDatiType.statoconservativo):
        return objectbox.getStatoConservativo();
      case (BaseDatiType.tipicontatti):
        return objectbox.getTipiContatti();
      case (BaseDatiType.tipistanza):
        return objectbox.getTipiStanze();
      case (null):
        return Stream<List<IDatiBase>>.empty();
    }
  }

  void removeDatiBase(int codEntity){
    switch(tipoDati){
      case (BaseDatiType.tipiimmobili):
        objectbox.removeTipologiaImmobile(codEntity);
      case (BaseDatiType.tipiclienti):
        objectbox.removeTipiClienti(codEntity);
      case (BaseDatiType.classeenergetica):
        objectbox.removeClasseEnergetica(codEntity);
      case (BaseDatiType.riscaldamenti):
        objectbox.removeRiscaldamento(codEntity);
      case (BaseDatiType.statoconservativo):
        objectbox.removeStatoConservativo(codEntity);
      case (BaseDatiType.tipicontatti):
        objectbox.removeTipologiaContatto(codEntity);
      case (BaseDatiType.tipistanza):
        objectbox.removeTipologiaStanza(codEntity);
      case (null):
    }
  }

  String deleteMessage(String entity){
    switch(tipoDati){
      case (BaseDatiType.tipiimmobili):
        return 'Tipo immobile ${entity} cancellato';
      case (BaseDatiType.tipiclienti):
        return 'Categoria cliente ${entity} cancellata';
      case (BaseDatiType.classeenergetica):
        return 'Classe energetica ${entity} cancellata';
      case (BaseDatiType.riscaldamenti):
        return 'Riscaldamento ${entity} cancellato';
      case (BaseDatiType.statoconservativo):
        return 'Stato conservativo ${entity} cancellato';
      case (BaseDatiType.tipicontatti):
        return 'Tipo contatto ${entity} cancellato';
      case (BaseDatiType.tipistanza):
        return 'Tipo stanza ${entity} cancellata';
      case (null):
        return 'Tipo sconosciuto impossibile cancellare';
    }
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: const Text('Errore'),
         content: Text(errorMessage),
         actions: <Widget>[
           TextButton(
             child: const Text('OK'),
             onPressed: () {
               Navigator.of(context).pop(); // Chiude il dialog
             },
           ),
         ],
       );
     },
   );
  }

  bool savePopUpdata(IDatiBase datobase){
    if (_formKey.currentState!.validate()) {
      switch(tipoDati){
        case (BaseDatiType.tipiimmobili):
          objectbox.tipologiaImmobileBox.put((datobase as TipologiaImmobile));
        case (BaseDatiType.tipiclienti):
          objectbox.classeClienteBox.put((datobase as ClasseCliente));
        case (BaseDatiType.classeenergetica):
          objectbox.classeEnergeticaBox.put((datobase as ClasseEnergetica));
        case (BaseDatiType.riscaldamenti):
          objectbox.riscaldamentoBox.put((datobase as Riscaldamento));
        case (BaseDatiType.statoconservativo):
          objectbox.statoConservativoBox.put((datobase as StatoConservativo));
        case (BaseDatiType.tipicontatti):
          objectbox.tipologiaContattoBox.put((datobase as TipologiaContatto));
        case (BaseDatiType.tipistanza):
          objectbox.tipologiaStanzaBox.put((datobase as TipologiaStanza));
        case (null):
      }
      setState(() {});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dati non validi impossibile procedere')),
      );
    }
    Navigator.of(context).pop();
    return true;
  }

   Future<dynamic> _openPopUp(BuildContext context, IDatiBase datobase) async {
     return showDialog(
         context: context,
         builder: (BuildContext dialogContext) {
           return AlertDialog(
             content: SizedBox(
               height: ((tipoDati==BaseDatiType.classeenergetica)?200:120),
               child: Form(
                   key: _formKey,
                   child:Column(
                     children: _getDialogWidgets(datobase),
                   )
               ),
             ),
               actions: [
                 TextButton(
                  style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const CircleBorder(),
                          ),
                  child: widget.saveIcon,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {

                      savePopUpdata(datobase);
                      setState(() {});
                    }else{
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dati non validi impossibile procedere')),
                      );
                    }
                    Navigator.of(dialogContext).pop();
                  },
                 ),
              ]
           );
         });
   }

   List<Widget> _getDialogWidgets(IDatiBase datobase){
     List<Widget> widgets =  List<Widget>.empty(growable: true);
     widgets.add(SizedBox(height: 5));
     String labeltxt = '';
     switch(tipoDati) {
       case (BaseDatiType.tipiimmobili):
         labeltxt = "Tipologia immobile";
       case (BaseDatiType.tipiclienti):
         labeltxt = "Categoria Cliente";
       case (BaseDatiType.classeenergetica):
         labeltxt = "Descrizione classe energetica";
         widgets.add(
             TextFormField(
               decoration:const InputDecoration(
                    labelText: "Nome classe energetica",
                    labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
               ),
               validator:  (value) {
                 if (value == null || value.isEmpty) {
                   return 'Inserire il nome';
                 }
                 return null;
               },
               onChanged: (text) {
                 datobase.setNome(text);
               },
               initialValue: datobase.getNome(),
             )
         );

       case (BaseDatiType.riscaldamenti):
         labeltxt = "Riscaldamento";
       case (BaseDatiType.statoconservativo):
         labeltxt = "Stato Conservativo";
       case (BaseDatiType.tipicontatti):
         labeltxt = "Tipologia Contatto";
       case (BaseDatiType.tipistanza):
         labeltxt = "Tipologia Stanza";
       case (null):
         labeltxt = "";
     }
     if (labeltxt != ""){
       widgets.add(
           TextFormField(
             decoration:InputDecoration(
                 labelText: labeltxt,
                 labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
             ),
             validator:  (value) {
               if (value == null || value.isEmpty || value.toString() == "") {
                 return 'Inserire la descrizione';
               }
               return null;
             },
             onChanged: (text) {
               datobase.setDescrizione(text);
             },
             initialValue: datobase.getDescrizione(),
           )
       );
       widgets.add(SizedBox(height: 5));
     }

     return widgets;
   }

}

class SwipeLeftNotification extends StatelessWidget {
  const SwipeLeftNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 20.0, bottom: 10.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Center(
          child: Text(
            'Delete a task by swiping it.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
