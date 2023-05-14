import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';


class Impostazioni extends StatefulWidget{

  final String title = 'Impostazioni';
  const Impostazioni({Key? key}): super(key: key);

  @override
  State<Impostazioni> createState() => _ImpostazioniState();
}

class _ImpostazioniState extends State<Impostazioni> {

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
          title: "Impostazioni",
          children:[
          //   ExpandableSettingsTile(
          //   title: 'Immagini',
          //   subtitle: '',
          //   children: <Widget>[
          //     DropDownSettingsTile<int>(
          //       title: 'Fattore riduzione immagini',
          //       settingKey: 'imageReductionFactor',
          //       values: <int, String>{
          //         0: '0%',
          //         25: '25%',
          //         50: '50%',
          //         75: '75%',
          //       },
          //       selected: 0,
          //       onChange: (value) {
          //         debugPrint('imageReductionFactor: $value days');
          //       },
          //     ),
          //     SliderSettingsTile(
          //       title: 'Qualità immagini salvate',
          //       settingKey: 'imageQuality',
          //       defaultValue: 20,
          //       min: 0,
          //       max: 100,
          //       step: 1,
          //       leading: Icon(Icons.image_sharp),
          //       onChange: (value) {
          //       debugPrint('imageQuality: $value');
          //       },
          //     ),
          //   ],
          // ),
          ExpandableSettingsTile(
          title: 'Installazione winkhouse',
          subtitle: '',
          children: <Widget>[
            TextInputSettingsTile(
              title: 'Indirizzo IP installazione',
              settingKey: 'ipWinkhouse',
              initialValue: '127.0.0.0',
              validator: (String ip) {
                  if (ip != null && ip.length > 6) {
                    return null;
                  }
                  return "Inserire indirizzo ip";
                },
              borderColor: Colors.blueAccent,
              errorColor: Colors.deepOrangeAccent,
            ),
            TextInputSettingsTile(
              title: 'Porta di ascolto winkhouse',
              settingKey: 'portWinkhouse',
              initialValue: '81',
              keyboardType: TextInputType.number,
              validator: (String port) {
              if (port != null && port.length < 5) {
              return null;
              }
              return "Inserire un numero da 81 a 65535";
              },
              borderColor: Colors.blueAccent,
              errorColor: Colors.deepOrangeAccent,
            )
          ]
          )
          ]
      );
  }
}