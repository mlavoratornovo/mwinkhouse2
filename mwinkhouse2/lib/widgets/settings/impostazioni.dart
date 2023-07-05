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
            ExpandableSettingsTile(
            title: 'Categorie',
            subtitle: 'Gestione dati da winkhouse',
            children: <Widget>[
              DropDownSettingsTile<int>(
                title: '',
                settingKey: 'baseDataMergeMode',
                values: const <int, String>{
                  0: 'Unisci come nuovi',
                  1: 'Aggiorna per codice',
                  2: 'Aggiorna per descrizione',
                  3: 'Cancella e sostituisci',
                },
                selected: 0,
                onChange: (value) {
                },
              ),
            ],
          ),
          ExpandableSettingsTile(
          title: 'Installazione winkhouse',
          subtitle: '',
          children: <Widget>[
            TextInputSettingsTile(
              title: 'Indirizzo IP installazione',
              settingKey: 'ipWinkhouse',
              initialValue: 'http://127.0.0.1',
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