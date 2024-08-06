import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

class Reclamation extends StatefulWidget {
  const Reclamation({super.key});

  @override
  State<Reclamation> createState() => _ReclamationState();
}

class _ReclamationState extends State<Reclamation> {
  @override
  String selectedRadioValue="";
  String textReclmation = "";
  void handleRadioChangedValue(String? value){
    setState(() {
      selectedRadioValue = value!;
    });
    print(selectedRadioValue);
  }
  final _formKey = GlobalKey<FormState>();
  bool success = false;
  bool submitted = false;
  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, String typeDeProbleme, String reclamationText) async {
    final url = Uri.parse("http://192.168.1.20:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
      'typeDeProbleme': typeDeProbleme,
      'reclamationText': reclamationText
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
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(future: UserPreferences.loadUser(), builder: (context, snapshot){
      if(!snapshot.hasData || snapshot.data == null){
        return Text("No user Data");
      }
      final user = snapshot.data!;
      return Scaffold(
        appBar: AppBar(
          title: Text('Faire Une Réclamation'),
        ),
        body: Center(
          child:
          Form(
            key: _formKey,
            child: Column(
              children: [
                RadioListTile(title:Text("Problème de Santé"),value: 'probleme santé', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                RadioListTile(title:Text("Problème Familiale"),value: 'probleme familiale', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                RadioListTile(title:Text("Problème de Travail"),value: 'probleme travail', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                RadioListTile(title:Text("Problème Direct Avec Directeur"),value: 'probleme directeur', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                RadioListTile(title:Text("Problème de Transport"),value: 'probleme transport', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                RadioListTile(title:Text("Problème d'Upgrade"),value: 'probleme upgrade', groupValue: selectedRadioValue, onChanged: handleRadioChangedValue),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "What's your problem",
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return '\nPlease Fill This box';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        textReclmation = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async{
                      await makePostRequest(user.NP, user.matricule, 'Reclamation', selectedRadioValue, textReclmation);
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
                    },
                    child: Text("Envoyer Reclamation"),
                  ),
                )
              ],
            ),
          ),

        ),
      );
    });

  }
}
