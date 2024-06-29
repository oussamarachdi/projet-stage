import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConjeDemande extends StatefulWidget {
  const ConjeDemande({super.key});

  @override
  _ConjeDemandeState createState() => _ConjeDemandeState();
}

class _ConjeDemandeState extends State<ConjeDemande> {
  bool success = false;
  bool submitted = false;

  final _formKey = GlobalKey<FormState>();
  String name = '';
  String matricule = '';
  String typeOfDemande = '';

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande) async {
    final url = Uri.parse(
        "http://127.0.0.1:3000/write"); // Replace with your API URL
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Matricule',
                ),
                onChanged: (value) {
                  matricule = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type Of Demande',
                ),
                onChanged: (value) {
                  typeOfDemande = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await makePostRequest(name, matricule, typeOfDemande);
                    }
                  },
                  child: const Text('Submit'),
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
    );
  }
}
