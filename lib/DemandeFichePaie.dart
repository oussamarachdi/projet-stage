import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demande de Fiche de Paie',
      home: DemandeFichePaieForm(),
    );
  }
}

class DemandeFichePaieForm extends StatefulWidget {
  @override
  _DemandeFichePaieFormState createState() => _DemandeFichePaieFormState();
}

class _DemandeFichePaieFormState extends State<DemandeFichePaieForm> {
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String prenom = '';
  String matricule = '';
  String mois = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande de Fiche de Paie'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                return null;
              },
              onSaved: (value) {
                nom = value ?? '';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Prénom'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                }
                return null;
              },
              onSaved: (value) {
                prenom = value ?? '';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Matricule'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre matricule';
                }
                return null;
              },
              onSaved: (value) {
                matricule = value ?? '';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mois'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le mois';
                }
                return null;
              },
              onSaved: (value) {
                mois = value ?? '';
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  // Enregistrer les données ou effectuer une action ici
                  print('Nom: $nom, Prénom: $prenom, Matricule: $matricule, Mois: $mois');
                }
              },
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}