import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse2/objbox/models/Colloquio.dart';

import '../../main.dart';
import '../../objbox/models/Immobile.dart';
import 'dettaglio_colloquio_immobile.dart';


class ColloquiImmobileList extends StatefulWidget {
  String title = '';
  Immobile immobile;
  ColloquiImmobileList({Key? key,required this.immobile}) : super(key: key){

    title = 'Lista colloqui : ${(immobile.indirizzo ?? "")}';
  }

  @override
  State<ColloquiImmobileList> createState() => _ColloquiImmobileListState();
}

class _ColloquiImmobileListState extends State<ColloquiImmobileList> {

  late Stream<List<Colloquio>?> colloqui;

  _ColloquiImmobileListState();

  Dismissible Function(BuildContext, int) _itemBuilder(List<Colloquio> colloquio) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          widget.immobile?.colloqui.removeWhere((element) => element.codColloquio == colloquio[index].codColloquio);
          objectbox.addImmobile(widget.immobile);
          objectbox.removeColloquio(colloquio[index].codColloquio ?? 0);
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text('Colloquio del ${colloquio[index].dataColloquio} cancellato'))));
        },
        child: Row(
          children: <Widget>[
            Checkbox(
                value: false, //immobili[index].isFinished(),
                onChanged: (bool? value) {
                  final colloquiosel = colloquio[index];
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
                        '${colloquio[index].tipologiaColloquio.target?.descrizione ?? ""} ${colloquio[index].dataColloquio}',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                        // Provide a Key for the integration test
                        key: Key('list_item_$index'),
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
                      builder: (context) => DettaglioColloquioImmobile(immobile: widget.immobile??Immobile(),
                        colloquio: colloquio[index],
                      )
                  ));
                }),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    colloqui = (() async* {
      await Future<void>.delayed(Duration(milliseconds: 1));
      yield widget.immobile?.colloqui.toList();
    })();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: StreamBuilder<List<Colloquio>?>(
                        stream: colloqui,
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
        backgroundColor: (widget.immobile==null)?Colors.grey:null,
        onPressed: (widget.immobile==null)?null:() async {
          final value = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DettaglioColloquioImmobile(immobile:widget.immobile??Immobile(), colloquio: Colloquio())));
          setState(() {});
        },
        child: const Icon(Icons.add),
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
