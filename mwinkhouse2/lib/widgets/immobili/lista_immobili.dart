import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';
import 'package:mwinkhouse/widgets/immobili/criteri_ricerca_immobili_editor_rest.dart';
import 'package:mwinkhouse/widgets/immobili/dettaglio_immobile.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili_proprieta.dart';

import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/Immobile.dart';
import '../../main.dart';
import 'criteri_ricerca_immobili_editor.dart';


/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class ImmobiliList extends StatefulWidget {
  late WinkhouseRest winkhouseRest;
  final String title = 'Lista immobili';
  Anagrafica? anagrafica;
  bool validConnection = false;
  List<int> idImmobili = [];

  ImmobiliList({super.key,this.anagrafica}){
    for (var i = 0; i < (anagrafica?.proprieta.length ?? 0); i++ ){
      idImmobili.add(anagrafica?.proprieta[i].codImmobile ?? 0);
    }
    winkhouseRest = WinkhouseRest();
  }

  @override
  State<ImmobiliList> createState() => _ImmobiliListState(anagrafica,idImmobili);
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

class _ImmobiliListState extends State<ImmobiliList> {
  Anagrafica? anagrafica;
  List<int> idImmobili = [];
  List<int> selected = [];
  _ImmobiliListState(this.anagrafica,this.idImmobili);

  Future<void> checkcon() async {

    widget.winkhouseRest.getTipologieImmobili()
        .then((value) =>  setState(() {widget.validConnection = true;}))
        .catchError((error, stack){
          widget.validConnection = false;
    });

  }

  @override
  void initState() {
    checkcon();
  }
  void _onCheckboxSelect(bool select, int codImmobile){
    if (select == true) {
      setState(() {
        selected.add(codImmobile);
      });
    } else {
      setState(() {
        selected.remove(codImmobile);
      });
    }
  }

  Dismissible Function(BuildContext, int) _itemBuilder(List<Immobile> immobili) =>
          (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Colors.red,
        ),
        key: UniqueKey(), //Key('dismissed_$index'),
        onDismissed: (direction) {
          // Remove the task from the store.
          objectbox.removeImmobileEntity(immobili[index]);
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
                value: (selected.get(index)!=null)?true:false,
                onChanged: (anagrafica == null)?null:(bool? value) {
                  final immobile = immobili[index];
                  _onCheckboxSelect(value!, immobile.codImmobile ?? 0);
                  if (value==true){
                    anagrafica?.proprieta.add(immobile);
                  }else{
                    anagrafica?.proprieta.remove(immobile);
                  }
                }),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    border:
                    Border(bottom: BorderSide(width:2.0, color: Colors.black12))),
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

            actions: [
          PopupMenuButton(itemBuilder: (context)=>const [
            PopupMenuItem(value: 0, child: Text('Ricerca')),
            PopupMenuItem(value: 1, child: Text('Ricerca remota'))
          ],
            onSelected: (result) {
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CriteriRicercaImmobileEditor())
                );
              }
              if (result == 1) {
                if (widget.validConnection) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          CriteriRicercaImmobileEditorRest())
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ip e porta winkouse non impostati o sbagliati')),
                  );
                }
              }
            },
          ),
        ]
    ),
    body: Center(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder<List<Immobile>>(
            stream: (anagrafica!=null)?objectbox.getImmobili(notin:idImmobili):objectbox.getImmobili(),
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
                FloatingActionButton(
                        heroTag: "immobili",
                        backgroundColor: (anagrafica!=null)?Colors.grey:null,
                        onPressed: (anagrafica!=null)?null:() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DettaglioImmobile(immobile:Immobile())));
                        },
                        child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: "immobili propieta",
                  backgroundColor: (anagrafica==null)?Colors.grey:null,
                  onPressed: (anagrafica==null)?null:() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImmobiliProprietaList(anagrafica: anagrafica??Anagrafica())));
                  },
                  child: const Icon(Icons.check_box),
                ),

              ])
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
