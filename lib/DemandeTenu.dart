import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

class DemandeTenuForm extends StatefulWidget {
  @override
  _DemandeTenuFormState createState() => _DemandeTenuFormState();
}

class _DemandeTenuFormState extends State<DemandeTenuForm> {
  final _formKey = GlobalKey<FormState>();
  String taille = '';
  bool _isSubmitting = false;
  bool _submissionSuccess = false;
  String _submissionMessage = '';

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, String taille) async {
    final url = Uri.parse("http://192.168.1.20:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
      'taille': taille,
    });

    setState(() {
      _isSubmitting = true;
      _submissionSuccess = false;
      _submissionMessage = '';
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          _submissionSuccess = true;
          _submissionMessage = 'Votre demande a été envoyée avec succès!';
        });
      } else {
        setState(() {
          _submissionSuccess = false;
          _submissionMessage = 'Échec de l\'envoi de la demande: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _submissionSuccess = false;
        _submissionMessage = 'Une erreur est survenue: $e';
      });
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: UserPreferences.loadUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No user data available'));
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Demande Tenu'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Taille - مقاس'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre taille';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      taille = value ?? '';
                    },
                  ),
                  SizedBox(height: 20),
                  _isSubmitting
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        await makePostRequest(user.NP, user.matricule, 'tenu', taille);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(_submissionSuccess ? 'Succès' : 'Échec'),
                              content: Text(_submissionSuccess
                                  ? 'Votre demande de congé a été envoyée avec succès.'
                                  : 'Échec de l\'envoi de votre demande. Veuillez réessayer.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    if (_submissionSuccess) {
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
                    child: Text('Soumettre', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  if (_submissionMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _submissionMessage,
                        style: TextStyle(
                          color: _submissionSuccess ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
