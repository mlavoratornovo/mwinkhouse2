import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse/widgets/anagrafiche/lista_anagrafiche.dart';
import 'package:mwinkhouse/widgets/basedata/base_data.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili.dart';
import 'package:mwinkhouse/widgets/settings/impostazioni.dart';
import 'package:mwinkhouse/objbox/dao/objectbox.dart';

late ObjectBox objectbox;

class BaseDataHome extends StatefulWidget {
  const BaseDataHome({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Lista categorie";

  @override
  State<BaseDataHome> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BaseDataHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Row(
              children: [
                const Image(image: AssetImage("assets/images/wink75.png")),
                const SizedBox(width: 4),
                Text(widget.title)]
          ),

        ),
        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImmobiliList()));
                },
                child:Container(
                  constraints: const BoxConstraints.expand(width:280,height:150.0),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 0)
                        )
                    ],
                      image: DecorationImage(
                          image: AssetImage("assets/images/tipiimmobili.jpg"),
                          fit: BoxFit.cover,
                          opacity: 1
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Implement the stroke
                      Text(
                        'TIPI IMMOBILI',
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5
                            ..color = Colors.blue,
                        ),
                      ),
                      // The text inside
                      const Text(
                        'TIPI IMMOBILI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                ),
              ),
              const SizedBox(height: 13),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnagraficheList()));
                },
                child:Container(
                  constraints: const BoxConstraints.expand(width:280,height:140.0),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0)
                        )
                      ],
                    image: DecorationImage(
                        image: AssetImage("assets/images/statoconservativo.jpg"),
                        fit: BoxFit.cover,
                        opacity: 1
                    ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Implement the stroke
                        Text(
                          'STATO IMMOBILE',
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = Colors.blue,
                          ),
                        ),
                        // The text inside
                        const Text(
                          'STATO IMMOBILE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 13),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BaseData()));
                },
                child:Container(
                        constraints: const BoxConstraints.expand(width:280,height:140.0),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 0)
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage("assets/images/classeenergetica.jpg"),
                              fit: BoxFit.fill,
                              opacity: 1
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                  child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Implement the stroke
                        Text(
                          'CLASSE IMMOBILE',
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = Colors.blue,
                          ),
                        ),
                        // The text inside
                        const Text(
                          'CLASSE IMMOBILE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 13),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Impostazioni()));
                },
                child:Container(
                        constraints: const BoxConstraints.expand(width:280,height:140.0),
                        decoration: const BoxDecoration(
                          boxShadow: [
                              BoxShadow(
                                  color: Colors.blueGrey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 0)
                              )
                            ],
                          image: DecorationImage(
                              image: AssetImage("assets/images/riscaldamenti.jpg"),
                              fit: BoxFit.cover,
                              opacity: 1
                          ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                  child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Implement the stroke
                        Text(
                          'RISCALDAMENTI',
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 5
                              ..color = Colors.blue,
                          ),
                        ),
                        // The text inside
                        const Text(
                          'RISCALDAMENTI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]
                  ),
                )
              )
            ],
          ),
        ),
    );
  }
}
