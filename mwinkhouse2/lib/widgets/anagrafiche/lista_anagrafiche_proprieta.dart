import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/widgets/anagrafiche/dettaglio_anagrafica.dart';
import '../../main.dart';
import '../../objbox/models/Immobile.dart';
import 'lista_anagrafiche.dart';


/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class AnagraficheProprietaList extends StatefulWidget {
  String title = 'Lista proprietari';
  Immobile immobile = Immobile();
  AnagraficheProprietaList({super.key,required this.immobile}){
    //this.immobile = immobile;
    //title = title + (immobile.indirizzo ?? "");
  }

  @override
  State<AnagraficheProprietaList> createState() => _AnagraficheProprietaListState();
}

class _AnagraficheProprietaListState extends State<AnagraficheProprietaList> {

  List<int> idproprietari = List<int>.empty(growable: true);

  late Stream<List<Anagrafica>?> proprietari;

  _AnagraficheProprietaListState();

  Dismissible Function(BuildContext, int) _itemBuilder(List<Anagrafica> anagrafiche) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          widget.immobile.proprietari.removeWhere((element) => element.codAnagrafica == anagrafiche[index].codAnagrafica);
          objectbox.addImmobile(widget.immobile);
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text('Anagrafica ${(anagrafiche[index].ragioneSociale ?? "")} ${(anagrafiche[index].cognome ?? "")} ${(anagrafiche[index].nome ?? "")} rimossa dai propietari'))));
        },
        child: Row(
          children: <Widget>[
            Checkbox(
                value: false, //immobili[index].isFinished(),
                onChanged: (bool? value) {
                  final anagrafica = anagrafiche[index];
                  // immobile.toggleFinished();
                  // objectbox.taskBox.put(task);
                  // List updated via watched query stream.
                }),
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
    widget.immobile.proprietari.map((element) => {
      idproprietari.add(element.codAnagrafica!)
    });
    proprietari = (() async* {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      yield widget.immobile.proprietari.toList();
    })();
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
                    child: StreamBuilder<List<Anagrafica>?>(
                        stream: proprietari,
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
      floatingActionButton:
        FloatingActionButton(
          heroTag: "immobile",
          backgroundColor: (widget.immobile.codImmobile==null)?Colors.grey:null,
          onPressed: (widget.immobile.codImmobile==null)?null:() async {
            final value = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnagraficheList(immobile:widget.immobile)));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
    );
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
