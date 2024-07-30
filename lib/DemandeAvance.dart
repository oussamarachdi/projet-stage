import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

class DemandeAvanceForm extends StatefulWidget {
  @override
  _DemandeAvanceFormState createState() => _DemandeAvanceFormState();
}

class _DemandeAvanceFormState extends State<DemandeAvanceForm> {
  final _formKey = GlobalKey<FormState>();
  String montant = '';
  String type = '';
  bool success = false;
  bool submitted = false;

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, String montant, String type) async {
    final url = Uri.parse("http://127.0.0.1:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
      'montant': montant,
      'typeAvance': type,
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
          return Center(child: Text('No user data available', style: TextStyle(fontSize: 18, color: Colors.red)));
        }
        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Demande Avance'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Montant (مبلغ)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le montant';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            montant = value ?? '';
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Type (نوع)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le type';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            type = value ?? '';
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              await makePostRequest(user.NP, user.matricule, 'avance', montant, type);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(success ? 'Succès' : 'Échec'),
                                    content: Text(success
                                        ? 'Votre demande a été soumise avec succès.'
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
                            padding: const EdgeInsets.only(top: 16.0),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
