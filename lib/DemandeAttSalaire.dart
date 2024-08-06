import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

class DemandeAttestationSalaireForm extends StatefulWidget {
  @override
  _DemandeAttestationSalaireFormState createState() => _DemandeAttestationSalaireFormState();
}

class _DemandeAttestationSalaireFormState extends State<DemandeAttestationSalaireForm> {
  final _formKey = GlobalKey<FormState>();
  bool success = false;
  bool submitted = false;

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande) async {
    final url = Uri.parse("http://192.168.1.20:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
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
      future: UserPreferences.loadUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Demande Attestation Salaire'),
            ),
            body: Center(
              child: Text('Aucune donnée utilisateur disponible', style: TextStyle(fontSize: 18, color: Colors.red)),
            ),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Demande Attestation Salaire'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Demande d\'attestation de salaire',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Cliquez sur "Soumettre" pour envoyer votre demande d\'attestation de salaire.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        await makePostRequest(user.NP, user.matricule, 'AttSalaire');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(success ? 'Succès' : 'Échec'),
                              content: Text(success
                                  ? 'Votre demande d\'attestation de salaire a été soumise avec succès.'
                                  : 'Une erreur est survenue lors de la soumission de votre demande.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (success) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Soumettre'),
                  ),
                  if (submitted && !success)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Erreur lors de l\'envoi de la demande. Veuillez réessayer.',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
