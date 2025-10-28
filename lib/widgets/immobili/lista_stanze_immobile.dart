import 'package:flutter/material.dart';
import '../../objbox/models/StanzaImmobile.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../objbox/models/Immobile.dart';
import 'dettaglio_stanza.dart';

class StanzeImmobileList extends StatefulWidget {
  String title = 'Lista stanze : ';
  Immobile immobile;
  StanzeImmobileList({super.key, required this.immobile}){
    //title = title + (immobile.indirizzo ?? "");
  }

  @override
  State<StanzeImmobileList> createState() => _StanzeImmobileListState();
}

class _StanzeImmobileListState extends State<StanzeImmobileList> {

  late Stream<List<StanzaImmobile>?> stanze;

  _StanzeImmobileListState();

  Dismissible Function(BuildContext, int) _itemBuilder(List<StanzaImmobile> stanza) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          widget.immobile.stanze.removeWhere((element) => element?.codStanzaImmobile == stanza[index].codStanzaImmobile);
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
                  child: Text('Stanza ${stanza[index].tipologiaStanza.target?.descrizione} cancellata'))));
        },
        child: Card(
          elevation: 4, // Ombra della card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                  value: false, //immobili[index].isFinished(),
                  onChanged: (bool? value) {
                    final anagrafica = stanza[index];
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
                          '${stanza[index].tipologiaStanza.target?.descrizione ?? ""} ${stanza[index].mq} mq',
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
                        builder: (context) => DettaglioStanza(immobile: widget.immobile,
                          stanzaImmobile: stanza[index],
                        )
                    ));
                  }),
            ],
          )
        ),
      );

  @override
  Widget build(BuildContext context) {
    stanze = (() async* {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      yield widget.immobile.stanze.toList();
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
                      builder: (context) => const MyHomePage(title: 'Winkhouse $versione',)
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
                    child: StreamBuilder<List<StanzaImmobile>?>(
                        stream: stanze,
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
              builder: (context) => DettaglioStanza(immobile:widget.immobile, stanzaImmobile: StanzaImmobile())));
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
