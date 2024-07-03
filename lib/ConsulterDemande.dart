import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

// Define Demande class to represent each item
class DemandeModel {
  final String name;
  final String matricule;
  final String typeOfDemande;
  final String etat;

  DemandeModel({
    required this.name,
    required this.matricule,
    required this.typeOfDemande,
    required this.etat,
  });

  factory DemandeModel.fromJson(Map<String, dynamic> json) {
    return DemandeModel(
      name: json['name'] ?? '',
      matricule: json['matricule'] ?? '',
      typeOfDemande: json['typeofdemande'] ?? '',
      etat: json['etat'] ?? '',
    );
  }
}

class Consulterdemande extends StatefulWidget {
  const Consulterdemande({Key? key}) : super(key: key);

  @override
  _ConsulterdemandeState createState() => _ConsulterdemandeState();
}

class _ConsulterdemandeState extends State<Consulterdemande> {
  late Future<List<DemandeModel>> futureDemandes;
  User? user;
  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  Future<void> loadUserData() async{
    User? loadUserData = await UserPreferences.loadUser();
    if(loadUserData != null){
      setState(() {
        user = loadUserData;
        futureDemandes = fetchDemandes(user!.matricule);
      });
    }
  }


  Future<List<DemandeModel>> fetchDemandes(String matricule) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:3000/read?matricule=$matricule"), headers: {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
    });
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<DemandeModel> demandes = jsonResponse.map((json) => DemandeModel.fromJson(json)).toList();
      return demandes;
    } else {
      throw Exception("Failed to load demandes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulter Vos Demandes'),
      ),
      body: Center(
        child: FutureBuilder<List<DemandeModel>>(
          future: futureDemandes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DemandeModel> demandes = snapshot.data!;
              print(demandes);
              return ListView.builder(
                itemCount: demandes.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: demandes[index].etat == 'En cours'
                        ? Colors.yellow
                        : demandes[index].etat == 'Validé'
                        ? Colors.green
                        : Colors.red,
                    child: ListTile(
                      title: Text(demandes[index].typeOfDemande, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                      subtitle: Text(demandes[index].name),
                      trailing: Text(demandes[index].etat),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

