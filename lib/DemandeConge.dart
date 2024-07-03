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
  String name = '';
  String matricule = '';
  String typeOfDemande = '';

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
    final url = Uri.parse("http://10.0.2.2:3000/write"); // Replace with your machine's IP address
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
        builder: (context, snapshot){
          if(!snapshot.hasData || snapshot.data == null){
            return Center(child: Text("No user Data",));
          }

          final user = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Demande de Congé -طلب اجازة '),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Date de début - تاريخ البدء') ,
                    onTap: () {
                      _selectDate(context);
                    },
                    trailing: _startDate != null
                        ? Text(_startDate!.toString())
                        : const Text('Choisir une date - حدد تاريخا'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nombre de jours - عدد الأيام  '),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _numberOfDays = int.tryParse(value ?? '');
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Raison - سبب'),
                    onSaved: (value) {
                      _reason = value ?? '';
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue)),
                      onPressed:  () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await makePostRequest(user.NP, user.matricule, "Congé", _numberOfDays, _reason, _startDate);
                        }
                      },
                      child: const Text('Envoyer la demande', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
          );
        });
  }
}
