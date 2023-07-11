import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwinkhouse2/main.dart';
import 'package:mwinkhouse2/objbox/models/Immagine.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../objbox/models/Immobile.dart';
import 'lista_immagini_immobile.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  Immobile immobile;
  bool doSave = false;
  late File fimg;

  DisplayPictureScreen({super.key, required this.imagePath, required this.immobile, required this.doSave}){
    fimg = File(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Text('Salva la foto')]
        )
      ),
      body: Image.file(fimg),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        backgroundColor: (doSave==false)?Colors.grey:null,
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          if (doSave == true) {
            try {
              final String path =  (await getApplicationDocumentsDirectory()).path;
              Immagine img = Immagine();
              img.pathImmagine = '$path/${immobile.codImmobile}/${basename(fimg.path)}';
              img.codImmobile = immobile.codImmobile;
              immobile.immagini.add(img);
              Directory d = Directory('$path/${immobile.codImmobile}');
              if (await d.exists() == false){
                 d.createSync(recursive: true);
              }
              await fimg.copy(img.pathImmagine??"");
              objectbox.immobileBox.put(immobile);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImmaginiImmobiliList(immobile: immobile)
              ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}