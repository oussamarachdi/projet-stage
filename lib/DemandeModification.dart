import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class DemandeModificationForm extends StatefulWidget {
  @override
  _DemandeModificationFormState createState() => _DemandeModificationFormState();
}

class _DemandeModificationFormState extends State<DemandeModificationForm> {
  final _formKey = GlobalKey<FormState>();
  String nouvelle_addresse  = '';
  String  nouvelle_addresse_email = '';
  String nouveau_numero_telephone='' ;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande modification '),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'nouvelle_addresse-العنوان الجديد'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nouvelle addresse';
                }
                return null;
              },
              onSaved: (value) {
                nouvelle_addresse= value ?? '';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'nouvelle_addresse_email-عنوان البريد الإلكتروني الجديد'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nouvelle addresse email';
                }
                return null;
              },
              onSaved: (value) {
                nouvelle_addresse_email = value ?? '';
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'nouveau_numero_telephone-رقم الهاتف الجديد'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nouveau numero telephone';
                }
                return null;
              },
              onSaved: (value) {
                nouveau_numero_telephone = value ?? '';
              },
            ),


            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  // Enregistrer les données ou effectuer une action ici
                  print('nouvelle_addresse: $nouvelle_addresse, nouvelle_addresse_email: $nouvelle_addresse_email , nouveau_numero_telephone: $nouveau_numero_telephone');
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