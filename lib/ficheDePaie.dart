import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

class PageDemandeFichePaie extends StatefulWidget {
  @override
  _PageDemandeFichePaieState createState() => _PageDemandeFichePaieState();
}

class _PageDemandeFichePaieState extends State<PageDemandeFichePaie> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String matricule = '';
  String _mois = '';

  bool success=false;
  bool submitted=false;

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, String mois) async {
    final url = Uri.parse("http://10.0.2.2:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
      'mois': mois
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      setState(() {
        success = response.statusCode == 200;
        submitted = true;
      });
    } catch (e) {
      setState(() {
        success = false;
        submitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: UserPreferences.loadUser()
        ,
        builder: (context, snapshot){
          if(!snapshot.hasData || snapshot.data == null){
            return Center(child: Text("No user Data",));
          }

          final user = snapshot.data!;
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
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // Envoyer les données à votre backend ou traiter les données ici
                          await makePostRequest(user.NP, user.matricule, "fichedePaie", _mois);
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
