import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mwinkhouse2/widgets/anagrafiche/lista_anagrafiche.dart';
import 'package:mwinkhouse2/widgets/basedata/base_data.dart';
import 'package:mwinkhouse2/widgets/immobili/lista_immobili.dart';
import 'package:mwinkhouse2/widgets/settings/impostazioni.dart';
import 'objbox/dao/objectbox.dart';

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
      home: const MyHomePage(title: 'Winkhouse 2'),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
/*
              SvgPicture.asset('assets/images/icon_flutter.svg',
                color: Colors.blueGrey[100],
                matchTextDirection: true,height: 100,
              )
*/
               Image.asset('assets/images/winkhouse450.png')
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "immobili",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImmobiliList()));
                },
                child: const Icon(Icons.home),
              ),
              FloatingActionButton(
                heroTag: "anagrafiche",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnagraficheList()));
                },
                child: const Icon(Icons.account_box),
              ),
              FloatingActionButton(
                heroTag: "datibase",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BaseData()));
                },

                child: const Icon(Icons.category),
              ),
              FloatingActionButton(
                heroTag: "impostazioni",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Impostazioni()));
                },
                child: const Icon(Icons.settings),
              )
            ],
          ),
        )
    );
  }
}
