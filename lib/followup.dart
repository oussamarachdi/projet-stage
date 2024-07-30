import 'package:flutter/material.dart';
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';


class FollowUp extends StatelessWidget {
  const FollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
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
                child: Image.asset(
                  "assets/logo.png",
                  width: 150,
                  height: 150,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal Information Section
                    Text(
                      "Informations Personnelles",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              label: "Nom et Prénom: ",
                              value: user.NP,
                            ),
                            InfoRow(
                              label: "Matricule: ",
                              value: user.matricule,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              label: "Date: ",
                              value: '${now.day}/${now.month}/${now.year}',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 40.0),

                    // Professional Information Section
                    const Text(
                      "Informations Professionnelles",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Divider(height: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InfoRow(
                          label: "Fonction SAP: ",
                          value: user.fctSAP,
                        ),
                        InfoRow(
                          label: "Poste: ",
                          value: user.pos,
                        ),
                        InfoRow(
                          label: "Contre Maitre: ",
                          value: user.contreMaitre,
                        ),
                      ],
                    ),
                    const Divider(height: 40.0),

                    // Credit Information Section
                    const Text(
                      "Informations de Macro",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Type de Macro"),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Montant"),
                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Graiet"),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("0"),
                                  ),
                                ),
                              ]
                          ),
                          TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("sulfat"),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("0"),
                                  ),
                                ),
                              ]
                          ),
                        ]
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );

  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final String? additionalValue;
  final bool isHeader;

  const InfoRow({
    required this.label,
    required this.value,
    this.additionalValue,
    this.isHeader = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: additionalValue != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isHeader ? 16 : 14,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            value,
          ),
          if (additionalValue != null) ...[
            SizedBox(width: 10.0),
            Text(
              additionalValue!,
            ),
          ],
        ],
      ),
    );
  }
}
