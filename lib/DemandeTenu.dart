import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DemandeTenuForm extends StatefulWidget {
  @override
  _DemandeTenuFormState createState() => _DemandeTenuFormState();
}

class _DemandeTenuFormState extends State<DemandeTenuForm> {
  final _formKey = GlobalKey<FormState>();
  String taille  = '';





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande Tenu '),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'taille-مقاس '),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre taille';
                }
                return null;
              },
              onSaved: (value) {
                taille= value ?? '';
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  // Enregistrer les données ou effectuer une action ici
                  print('taille: $taille');
                }
              },
              child: Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }
}