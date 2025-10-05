import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/objbox/models/Contatto.dart';
import 'package:mwinkhouse/widgets/anagrafiche/dettaglio_contatto.dart';

import '../../constants.dart';
import '../../main.dart';

class ContattiAnagraficaList extends StatefulWidget {
  String title = "";
  Anagrafica anagrafica;
  ContattiAnagraficaList({super.key,required this.anagrafica}){
    title = "Lista contatti : ";
  }

  @override
  State<ContattiAnagraficaList> createState() => _ContattiAnagraficaListState();
}

class _ContattiAnagraficaListState extends State<ContattiAnagraficaList> {

  late Stream<List<Contatto>?> contatti;

  _ContattiAnagraficaListState();

  Dismissible Function(BuildContext, int) _itemBuilder(List<Contatto> contatto) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          widget.anagrafica.contatti.removeWhere((element) => element.codContatto == contatto[index].codContatto);
          objectbox.addAnagrafica(widget.anagrafica);
          // List updated via watched query stream.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(bottom: 0, right: 70, left: 70),
              padding: const EdgeInsets.all(5),
              duration: const Duration(milliseconds: 800),
              content: Container(
                  alignment: Alignment.center,
                  height: 35,
                  child: Text('Contatto ${contatto[index].contatto} cancellato'))));
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
                    final contattosel = contatto[index];
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
                          '${contatto[index].tipologiaContatto.target?.descrizione ?? ""} ${contatto[index].contatto}',
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
                        builder: (context) => DettaglioContatto(anagrafica: widget.anagrafica,
                          contatto: contatto[index],
                        )
                    ));
                  }),
            ],
          ),
        )
      );

  @override
  Widget build(BuildContext context) {
    contatti = (() async* {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      yield widget.anagrafica.contatti.toList();
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
                    child: StreamBuilder<List<Contatto>?>(
                        stream: contatti,
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
        backgroundColor: (widget.anagrafica==null)?Colors.grey:null,
        onPressed: () async {
          final value = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DettaglioContatto(anagrafica:widget.anagrafica, contatto: Contatto())));
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
