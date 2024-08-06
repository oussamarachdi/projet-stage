import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemandeCredit extends StatefulWidget {
  const DemandeCredit({super.key});

  @override
  _DemandeCreditState createState() => _DemandeCreditState();
}

class _DemandeCreditState extends State<DemandeCredit> {
  bool success = false;
  bool submitted = false;

  final _formKey = GlobalKey<FormState>();
  String name = '';
  String matricule = '';
  String typeOfDemande = '';


  Future<void> makePostRequest(String name, String matricule, String typeOfDemande) async {
    final url = Uri.parse("http://192.168.1.20:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande
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
        builder: (context, snapshot){
          if(!snapshot.hasData || snapshot.data == null){
            return Center(child: Text("No user Data",));
          }

          final user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/logo.jpeg", width: 150, height: 150),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Press Submit To Send A Demande", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                          ),

                          child: const Text('Submit', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await makePostRequest(user.NP, user.matricule, "Conjé");
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

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          submitted
                              ? success
                              ? 'Your demande has been successfully sent'
                              : 'Failed to send your demande. Please try again.'
                              : '',
                          style: TextStyle(
                            color: success ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

        }
    );

  }
}
