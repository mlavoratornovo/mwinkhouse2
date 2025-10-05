import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse/objbox/models/Immagine.dart';
import 'package:mwinkhouse/widgets/immobili/scatta_foto.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../objbox/models/Immobile.dart';
import 'dettaglio_foto.dart';

class ImmaginiImmobiliList extends StatefulWidget {
  String title = 'Lista immagini : ';
  Immobile immobile;

  ImmaginiImmobiliList ({super.key, required this.immobile}){
    title = "Lista immagini : ";
  }

  @override
  State<ImmaginiImmobiliList> createState() => _ImmaginiImmobiliListState();
}

class _ImmaginiImmobiliListState extends State<ImmaginiImmobiliList> {

  late Stream<List<Immagine>?> immagini;

  _ImmaginiImmobiliListState();

  Dismissible Function(BuildContext, int) _itemBuilder(
      List<Immagine> immagine) =>
          (BuildContext context, int index) =>
          Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: UniqueKey(), //Key('dismissed_$index'),
            onDismissed: (direction) {
              // Remove the task from the store.
              widget.immobile.immagini.removeWhere((element) =>
              element.codImmagine == immagine[index].codImmagine);
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
                      child: Text('Immagine ${immagine[index]
                          .pathImmagine} cancellata'))));
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPictureScreen(
                                // Pass the automatically generated path to
                                // the DisplayPictureScreen widget.
                                imagePath: immagine[index].pathImmagine??"",
                                immobile: widget.immobile,
                                doSave: false,
                              )),);
                            },
                            child: Image.file(File(immagine[index].pathImmagine??""),width: 75,height: 75,)
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

  @override
  Widget build(BuildContext context) {
    immagini = (() async* {
      await Future<void>.delayed(const Duration(milliseconds: 1));
      yield widget.immobile.immagini.toList();
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
                    child: StreamBuilder<List<Immagine>?>(
                        stream: immagini,
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
                                  const EdgeInsets.only(top: 16,
                                      left: 16,
                                      right: 16),
                                  child: Text('Error: ${snapshot.error}'),
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                itemCount: snapshot.hasData ? snapshot.data!
                                    .length : 0,
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
            heroTag: "immagineadd",
            backgroundColor: (widget.immobile == null) ? Colors.grey : null,
            onPressed: (widget.immobile == null) ? null : () async {
              final cameras = await availableCameras();
              final firstCamera = cameras.first;
              final value = await Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => TakePictureScreen(immobile:widget.immobile,camera: firstCamera,)));
               setState(() {});
            },
            child: const Icon(Icons.add),
          ),

    );
  }
}