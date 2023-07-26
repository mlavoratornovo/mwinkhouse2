import 'package:flutter/material.dart';
import 'package:mwinkhouse/widgets/immobili/dettaglio_immobile.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili_proprieta.dart';

import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/CriteriRicercaImmobile.dart';
import '../../objbox/models/Immobile.dart';
import '../../main.dart';
import '../../objbox/models/TipologiaImmobile.dart';
import 'criteri_ricerca_immobili_editor.dart';


/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class ImmobiliRicercaRestList extends StatefulWidget {

  final String title = 'Ricerca remota';
  CriteriRicercaImmobile? criteri;
  late WinkhouseRest winkhouseRest;
  Map<int,TipologiaImmobile> tipologieImmobile = <int,TipologiaImmobile>{};

  ImmobiliRicercaRestList({Key? key,this.criteri}) : super(key: key){
    winkhouseRest = WinkhouseRest();
  }

  @override
  State<ImmobiliRicercaRestList> createState() => _ImmobiliRicercaRestListState();
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

class _ImmobiliRicercaRestListState extends State<ImmobiliRicercaRestList> {

  _ImmobiliRicercaRestListState();

  Future<void> checkcon() async {

    widget.winkhouseRest.getTipologieImmobili()
        .then((value) =>  setState(() {
          widget.tipologieImmobile = { for (var v in value) v.codTipologiaImmobile??0 : v };
        }))
        .catchError((error, stack){
    });

  }

  @override
  void initState() {
    checkcon();
  }

  Widget Function(BuildContext, int) _itemBuilder(List<Immobile> immobili) =>
          (BuildContext context, int index) =>  Container(
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
                        '${immobili[index].citta} ${immobili[index].indirizzo} (Tipo: ${immobili[index].tipologiaImmobile.target?.descrizione.toString() ?? ""})',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                        // Provide a Key for the integration test
                        key: Key('list_item_$index'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Classe:${immobili[index].classeEnergetica.target?.nome.toString()} \n'
                              'Riscaldamento: ${immobili[index].riscaldamento.target?.descrizione.toString()} \n'
                              'Stato: ${immobili[index].statoConservativo.target?.descrizione.toString()}' ,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DettaglioImmobile(
                        immobile: immobili[index],
                        bindRest: true,
                      )
                  ));
                }),
          ],
        ),
      );

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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: StreamBuilder<List<Immobile>>(
                          stream: widget.winkhouseRest.findImmobili(criteri: widget.criteri??CriteriRicercaImmobile(),tipologieImmobili: widget.tipologieImmobile),
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
    );
  }
}

class SwipeLeftNotification extends StatelessWidget {
  const SwipeLeftNotification({Key? key}) : super(key: key);

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
