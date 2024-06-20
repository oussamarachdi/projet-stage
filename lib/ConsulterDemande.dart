import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Define Demande class to represent each item
class Demande {
  final String name;
  final String matricule;
  final String typeOfDemande;
  final String etat;

  Demande({
    required this.name,
    required this.matricule,
    required this.typeOfDemande,
    required this.etat,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
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
  late Future<List<Demande>> futureDemandes;

  @override
  void initState() {
    super.initState();
    futureDemandes = fetchDemandes();
  }

  Future<List<Demande>> fetchDemandes() async {
    final response = await http.get(Uri.parse("http://localhost:3000/read"));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Demande> demandes = jsonResponse.map((json) => Demande.fromJson(json)).toList();
      return demandes;
    } else {
      throw Exception("Failed to load demandes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des demandes'),
      ),
      body: Center(
        child: FutureBuilder<List<Demande>>(
          future: futureDemandes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Demande> demandes = snapshot.data!;
              return ListView.builder(
                itemCount: demandes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(demandes[index].name),
                    subtitle: Text(demandes[index].typeOfDemande),
                    trailing: Text(demandes[index].etat),
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
