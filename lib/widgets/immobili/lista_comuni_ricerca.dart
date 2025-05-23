import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Anagrafica.dart';

import '../../objbox/dao/winkhouse_rest.dart';
import '../../objbox/models/Comune.dart';
import '../../objbox/models/Immobile.dart';
import '../../main.dart';

/// Displays the current list of tasks by listening to a stream.
///
/// Each task has a check button to mark it completed and an edit button to
/// update it. A task can also be swiped away to remove it.
class ListaComuniRicerca extends StatefulWidget {

  final String title = 'Ricerca comuni';
  Immobile? immobile;
  Anagrafica? anagrafica;
  String comuneSearch='';
  late WinkhouseRest winkhouseRest;
  ListaComuniRicerca({super.key,this.immobile,this.anagrafica}){
    winkhouseRest = WinkhouseRest();
  }

  @override
  State<ListaComuniRicerca> createState() => _ListaComuniRicercaState();
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

class _ListaComuniRicercaState extends State<ListaComuniRicerca> {

  _ListaComuniRicercaState();

  Widget Function(BuildContext, int) _itemBuilder(List<Comune> comuni) =>
          (BuildContext context, int index) => Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: (){
                  if (widget.immobile != null) {
                    widget.immobile?.citta = comuni[index].comune;
                    widget.immobile?.provincia = comuni[index].provincia;
                    widget.immobile?.cap = comuni[index].cap;
                  }
                  if (widget.anagrafica != null){
                    widget.anagrafica?.citta = comuni[index].comune;
                    widget.anagrafica?.provincia = comuni[index].provincia;
                    widget.anagrafica?.cap = comuni[index].cap;
                  }
                  Navigator.pop(context);
                },
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
                          'Cod. Istat:${comuni[index].codIstat} Nome: ${comuni[index].comune})',
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.none),
                          // Provide a Key for the integration test
                          key: Key('list_item_$index'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Regione:${comuni[index].regione} \n'
                                'Provincia: ${comuni[index].provincia} \n'
                                'Cap: ${comuni[index].cap}' ,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
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
                  TextField(
                    decoration:const InputDecoration(
                        labelText: "Comune da ricercare"
                    ),
                    onChanged: (text) {
                      setState(() {
                        widget.comuneSearch = text;
                      });
                    },
                  ),
                  Expanded(
                      child: StreamBuilder<List<Comune>>(
                          stream: widget.comuneSearch.length >= 3?widget.winkhouseRest.findComuni(widget.comuneSearch??''):null,
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
