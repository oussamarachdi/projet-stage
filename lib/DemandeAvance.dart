import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DemandeAvance extends StatefulWidget {
  @override
  _DemandeAvanceState createState() => _DemandeAvanceState();
}

class _DemandeAvanceState extends State<DemandeAvance> {
  final _transportFormKey = GlobalKey<FormState>();
  final _myFormKey = GlobalKey<FormState>();
  String gouvernorat = '';
  String ville = '';
  String nombre_de_passagers_familiaux = '';
  String nom_de_partenaire = '';
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combined Form'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Form(
            key: _transportFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'gouvernorat-ولاية'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre gouvernorat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    gouvernorat = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ville-مدينة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ville';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    ville = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'nombre_de_passagers_familiaux-عدد الركاب من العائلة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nombre_de_passagers_familiaux';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nombre_de_passagers_familiaux = value ?? '';
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'nom_de_partenaire-اسم شريك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom_de_partenaire';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nom_de_partenaire = value ?? '';
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_transportFormKey.currentState?.validate() ?? false) {
                      _transportFormKey.currentState?.save();
                      print(
                        '$gouvernorat, gouvernorat: $ville, ville: $nombre_de_passagers_familiaux, nombre_de_passagers_familiaux: $nom_de_partenaire, nom_de_partenaire',
                      );
                    }
                  },
                  child: Text('Soumettre Transport'),
                ),
              ],
            ),
          ),
          Form(
            key: _myFormKey,

            child: Column(
              children: [
                for (int i = 0; i < 4; i++)
                  TextFormField(
                    controller: controllers[i],

                    decoration: InputDecoration(

                      labelText : 'l'' enfant-الطفل  :',
                      hintText: 'prénom et âge -  الاسم والعمر',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك أدخل قيمة';
                      }
                      return null;
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_myFormKey.currentState!.validate()) {
                      print(controllers[0].text);
                      print(controllers[1].text);
                      print(controllers[2].text);
                      print(controllers[3].text);
                    };
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
