import 'package:flutter/material.dart';
class followup extends StatelessWidget {
  const followup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20,20), // Adjust the padding values as needed
          child: Image.asset(
            "assets/logo.jpeg",
            width: 150,
            height: 150,
          ),
        ),
      ),
      body: const Center(
        child:  Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : <Widget>[
                      Row(
                        children: [
                          Text("Nom et Prénom: ", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Oussama Rachdi")
                        ],
                      ),
                      Row(
                        children: [
                          Text("Matricule: ",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("21Pri077")
                        ],
                      ),
                    ]
                  ),
                  Row(
                    children: [
                      Text("Date : ", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("24/10/2002")
                    ],
                  )
                ],
              ),
              Divider(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Fonction SAP:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Chef Segment"),
                  SizedBox(width: 10.0,),
                  Text("Poste:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Operateur"),
                  SizedBox(width: 10.0,),
                  Text("Contre Maitre:",style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Imen")
                ],
              ),
              Divider(height: 60.0),
              // Credit
              Row(
                children: [
                  Text("Credit Total: ",style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("1500Dt"),
                ],
              ),
              SizedBox(height: 10.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Type"),
                      Text("Montant")
                    ],
                  ),
                  Divider(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Type"),
                      Text("0")
                    ],
                  ),
                  Divider(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Type"),
                      Text("0")
                    ],
                  )
                ],
              ),
              Text("Consulter vos demande: ",style: TextStyle(fontWeight: FontWeight.bold)),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Type de demande"),
                      SizedBox(width: 20.0,),
                      Text("Date"),
                      SizedBox(width: 20.0,),
                      Text("Validation")
                    ],
                  ),
                  Divider(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Conjé"),
                      SizedBox(width: 20.0,),
                      Text("24/06/2024"),
                      SizedBox(width: 20.0,),
                      Text("En cours")
                    ],
                  ),
                  Divider(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Avance"),
                      SizedBox(width: 20.0,),
                      Text("24/06/2021"),
                      SizedBox(width: 20.0,),
                      Text("Non")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
