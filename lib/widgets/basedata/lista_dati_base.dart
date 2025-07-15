import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/objbox/models/IDatiBase.dart';
import 'package:mwinkhouse/widgets/anagrafiche/dettaglio_anagrafica.dart';

import '../../main.dart';
import '../../objbox/models/Immobile.dart';

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
  String title = '';
  BaseDatiType tipoDati = BaseDatiType.tipiimmobili;

  BaseDatiList({super.key, required this.tipoDati}){
    this.tipoDati = tipoDati;
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

  Dismissible Function(BuildContext, int) _itemBuilder<T>(List<IDatiBase> datibase) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          // objectbox.removeAnagraficaEntity(datibase[index]);
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text('Immobile ${datibase[index].getCodice()} deleted'))));
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
/*
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DettaglioAnagrafica(
                        anagrafica: datibase[index],
                      )
                  ));
*/
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
        body: Center(
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
        floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
/*
              FloatingActionButton(
                heroTag: "Anagrafica",
                backgroundColor: (immobile!=null)?Colors.grey:null,
                onPressed: (immobile!=null)?null:() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DettaglioAnagrafica(anagrafica:Anagrafica())));
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: "immobili",
                backgroundColor: (immobile==null)?Colors.grey:null,
                onPressed: (immobile==null)?null:() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnagraficheProprietaList(immobile:immobile?? Immobile())));
                },
                child: const Icon(Icons.check_box),
              ),
*/
            ]
        ));
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
