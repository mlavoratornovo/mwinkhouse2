import 'package:flutter/material.dart';
import '../../objbox/models/Anagrafica.dart';
import '../../objbox/models/CriteriRicercaAnagrafica.dart';
import 'dettaglio_anagrafica.dart';

import '../../constants.dart';
import '../../main.dart';


/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class AnagraficheRicercaList extends StatefulWidget {
  final String title = 'Lista anagrafiche ricerca';

  CriteriRicercaAnagrafica? criteri;

  AnagraficheRicercaList({super.key, this.criteri});

  @override
  State<AnagraficheRicercaList> createState() => _AnagraficheRicercaListState();
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

class _AnagraficheRicercaListState extends State<AnagraficheRicercaList> {

  List<int> selected = [];
  final Set<Anagrafica> _selectedItems = {};
  _AnagraficheRicercaListState();


  void _onCheckboxSelect(bool select, int codAnagrafica){
    if (select == true) {
      setState(() {
        selected.add(codAnagrafica);
      });
    } else {
      setState(() {
        selected.remove(codAnagrafica);
      });
    }
  }

  Dismissible Function(BuildContext, int) _itemBuilder(List<Anagrafica> anagrafiche) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
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
                      Checkbox(
                        value: _selectedItems.contains(anagrafiche[index]),
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedItems.add(anagrafiche[index]);
                            } else {
                              _selectedItems.remove(anagrafiche[index]);
                            }
                          });
                        },
                      ),
                      Text(
                        '${anagrafiche[index].ragioneSociale ?? ""} ${anagrafiche[index].cognome} ${anagrafiche[index].nome}',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                        // Provide a Key for the integration test
                        key: Key('list_item_$index'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          anagrafiche[index].classeCliente.target?.descrizione.toString() ?? "",
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
                      builder: (context) => DettaglioAnagrafica(
                        anagrafica: anagrafiche[index],
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
                        builder: (context) => const MyHomePage(title: 'Winkhouse $versione',)
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
                      child: StreamBuilder<List<Anagrafica>?>(
                          stream: objectbox.searchAnagrafiche(criteri: widget.criteri??CriteriRicercaAnagrafica()),
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
          floatingActionButton: _selectedItems.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  // Restituisce la lista delle anagrafiche selezionate al chiamante
                  Navigator.pop(context, _selectedItems.toList());
                },
                label: Text('Seleziona (${_selectedItems.length})'),
                icon: const Icon(Icons.check),
                backgroundColor: Colors.blue,
              )
          : null, // Se non ci sono selezioni, il pulsante non viene renderizzato
    );
  }
}

