import 'package:flutter/material.dart';

class PageDemandeFichePaie extends StatefulWidget {
  @override
  _PageDemandeFichePaieState createState() => _PageDemandeFichePaieState();
}

class _PageDemandeFichePaieState extends State<PageDemandeFichePaie> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nom = '';
  String _prenom = '';
  String _matricule = '';
  String _mois = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demande de Fiche de Paie'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nom = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _prenom = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Matricule'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre matricule';
                  }
                  return null;
                },
                onSaved: (value) {
                  _matricule = value ?? '';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mois'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le mois';
                  }
                  return null;
                },
                onSaved: (value) {
                  _mois = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Envoyer les données à votre backend ou traiter les données ici
                    print('Nom: $_nom, Prénom: $_prenom, Matricule: $_matricule, Mois: $_mois');
                  }
                },
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Travail1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page suivante'),
      ),
      body: Center(
        child: Text(
          'Ceci est la page suivante',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
