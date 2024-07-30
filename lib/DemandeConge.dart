import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'dart:convert';
import 'package:projet_stage/user_preferences.dart';

class DemandeConge extends StatefulWidget {
  const DemandeConge({Key? key}) : super(key: key);

  @override
  _DemandeCongeState createState() => _DemandeCongeState();
}

class _DemandeCongeState extends State<DemandeConge> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  int? _numberOfDays;
  String _reason = '';
  bool success = false;
  bool submitted = false;

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _startDate = pickedDate;
        });
      }
    });
  }

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, int? numberOfDays, String reason, DateTime? startDate) async {
    final url = Uri.parse("http://127.0.0.1:3000/write"); // Replace with your machine's IP address
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "name": name,
      "matricule": matricule,
      "typeOfDemande": typeOfDemande,
      "numberOfDays": numberOfDays,
      "reason": reason,
      "startDate": startDate?.toIso8601String()
    });

    print("Request Body: $body"); // Debugging line

    try {
      final response = await http.post(url, headers: headers, body: body);
      print("Response: ${response.body}"); // Debugging line
      setState(() {
        success = response.statusCode == 200;
        submitted = true;
      });
    } catch (e) {
      print("Error: $e"); // Debugging line
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
              title: const Text('Demande de Congé - طلب إجازة'),
            ),
            body: Center(
              child: Text(
                'Aucune donnée utilisateur disponible',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Demande de Congé - طلب إجازة'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    title: const Text('Date de début - تاريخ البدء'),
                    onTap: () => _selectDate(context),
                    trailing: Text(
                      _startDate != null ? "${_startDate!.toLocal().toShortDateString()}" : 'Choisir une date - حدد تاريخا',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nombre de jours - عدد الأيام'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nombre de jours';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _numberOfDays = int.tryParse(value ?? '');
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Raison - سبب'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer la raison de la demande';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _reason = value ?? '';
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        await makePostRequest(user.NP, user.matricule, "Congé", _numberOfDays, _reason, _startDate);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(success ? 'Succès' : 'Échec'),
                              content: Text(success
                                  ? 'Votre demande de congé a été envoyée avec succès.'
                                  : 'Échec de l\'envoi de votre demande. Veuillez réessayer.'),
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
                    child: const Text(
                      'Envoyer la demande',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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

extension DateFormatting on DateTime {
  String toShortDateString() {
    return "${this.day}/${this.month}/${this.year}";
  }
}
