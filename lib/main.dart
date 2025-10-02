import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse/widgets/anagrafiche/lista_anagrafiche.dart';
import 'package:mwinkhouse/widgets/basedata/home_dati_base.dart';
import 'package:mwinkhouse/widgets/immobili/lista_immobili.dart';
import 'package:mwinkhouse/widgets/settings/impostazioni.dart';
import 'objbox/dao/objectbox.dart';
import 'package:mwinkhouse/constants';

late ObjectBox objectbox;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  Settings.init();
  runApp(const MyApp());
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winkhouse 2',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Winkhouse $versione'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                          image: AssetImage("assets/images/immobili.jpg"),
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
                        'IMMOBILI',
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
                        'IMMOBILI',
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
                        image: AssetImage("assets/images/anagrafiche.jpg"),
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
                          'ANAGRAFICHE',
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
                          'ANAGRAFICHE',
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
                      builder: (context) => BaseDataHome()));
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
                              image: AssetImage("assets/images/categorie.jpg"),
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
                          'CATEGORIE',
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
                          'CATEGORIE',
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
                              image: AssetImage("assets/images/impostazioni.jpg"),
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
                          'IMPOSTAZIONI',
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
                          'IMPOSTAZIONI',
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
