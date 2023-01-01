import 'package:flutter/material.dart';
import 'package:mwinkhouse2/widgets/dettaglio_immobile.dart';

import '../objbox/models/Immobile.dart';
import '../main.dart';


/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class ImmobiliList extends StatefulWidget {
  final String title = 'Lista immobili';
  const ImmobiliList({Key? key}) : super(key: key);

  @override
  State<ImmobiliList> createState() => _ImmobiliListState();
}

class _ImmobiliListState extends State<ImmobiliList> {
  Dismissible Function(BuildContext, int) _itemBuilder(List<Immobile> immobili) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          objectbox.removeImmobile(immobili[index].codImmobile?.toInt() ?? 0);
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text('Immobile ${immobili[index].codImmobile} deleted'))));
        },
        child: Row(
          children: <Widget>[
            Checkbox(
                value: false, //immobili[index].isFinished(),
                onChanged: (bool? value) {
                  final immobile = immobili[index];
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
                        '${immobili[index].indirizzo} (Tipo: ${immobili[index].tipologiaImmobile.target?.descrizione.toString() ?? ""})',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                        // Provide a Key for the integration test
                        key: Key('list_item_$index'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          immobili[index].classeEnergetica.target?.nome.toString() ?? "",
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
        title: Text(widget.title),
    ),
    body: Center(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<List<Immobile>>(
            stream: objectbox.getImmobili(),
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
            floatingActionButton: FloatingActionButton(
                        heroTag: "immobili",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DettaglioImmobile(immobile:Immobile())));
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
