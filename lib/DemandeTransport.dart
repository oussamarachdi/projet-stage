import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'dart:convert';
import 'package:projet_stage/user_preferences.dart';

class DemandetransportForm extends StatefulWidget {
  @override
  _DemandetransportFormState createState() => _DemandetransportFormState();
}

class _DemandetransportFormState extends State<DemandetransportForm> {
  final _transportFormKey = GlobalKey<FormState>();
  final _myFormKey = GlobalKey<FormState>();
  String gouvernorat = '';
  String ville = '';
  String nombreDePassagersFamiliaux = '';
  String nomDePartenaire = '';
  int numberOfChildren = 0;
  bool _isSubmitting = false;
  bool _submissionSuccess = false;
  String _submissionMessage = '';
  List<TextEditingController> _childControllers = [];

  @override
  void initState() {
    super.initState();
    _updateChildControllers();
  }

  void _updateChildControllers() {
    setState(() {
      _childControllers = List.generate(numberOfChildren, (index) => TextEditingController());
    });
  }

  String _getChildrenNames() {
    return _childControllers.map((controller) => controller.text).where((name) => name.isNotEmpty).join('-');
  }

  Future<void> makePostRequest(String name, String matricule, String typeOfDemande, String gouvernorat, String ville, String nbrePassager, String nomPartenaire, int numberOfChildren,String childrenNames) async {
    final url = Uri.parse("http://192.168.1.20:3000/write"); // Replace with your API URL
    final headers = {"Content-Type": 'application/json'};
    final body = json.encode({
      'name': name,
      'matricule': matricule,
      'typeOfDemande': typeOfDemande,
      'gouvernorat': gouvernorat,
      'ville': ville,
      'nbrePassager': nbrePassager,
      'nomPartenaire': nomPartenaire,
      'numberOfChildren': numberOfChildren,
      'childrenNames': childrenNames,
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
          return Scaffold(
            appBar: AppBar(title: Text('Demande Transport')),
            body: Center(child: Text('No User Data')),
          );
        }

        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Demande Transport'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Form(
                  key: _transportFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Gouvernorat - ولاية'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre gouvernorat';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          gouvernorat = value ?? '';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Ville - مدينة'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre ville';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          ville = value ?? '';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nombre de passagers familiaux - عدد الركاب من العائلة'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nombre de passagers familiaux';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nombreDePassagersFamiliaux = value ?? '';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nom de partenaire - اسم شريك'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nom de partenaire';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nomDePartenaire = value ?? '';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: numberOfChildren.toString(),
                        decoration: InputDecoration(labelText: 'Nombre d\'enfants - عدد الأطفال'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            numberOfChildren = int.tryParse(value) ?? 0;
                            _updateChildControllers();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _childControllers.map((controller) {
                          int index = _childControllers.indexOf(controller);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      labelText: 'Enfant ${index + 1} - الطفل ${index + 1}',
                                      hintText: 'Prénom et âge - الاسم والعمر',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      _isSubmitting
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: () async {
                          if (_transportFormKey.currentState!.validate() && _myFormKey.currentState!.validate()) {
                            _transportFormKey.currentState?.save();
                            _myFormKey.currentState?.save();
                            final childrenNames = _getChildrenNames();
                            await makePostRequest(user.NP, user.matricule, 'Transport', gouvernorat, ville, nombreDePassagersFamiliaux, nomDePartenaire, numberOfChildren,childrenNames);
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
                        child: Text('Envoyer la demande'),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
