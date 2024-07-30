import 'package:flutter/material.dart';
import 'package:projet_stage/DemandeAttSalaire.dart';
import 'package:projet_stage/DemandeAttestationTravail.dart';
import 'package:projet_stage/DemandeAvance.dart';
import 'package:projet_stage/DemandeConge.dart';
import 'package:projet_stage/Reclamation.dart';
import 'package:projet_stage/ficheDePaie.dart';

import 'DemandeModification.dart';
import 'DemandeTenu.dart';
import 'DemandeTransport.dart';
class Demande extends StatelessWidget {
  const Demande ({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Center (
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Stack (
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            color: Colors.blue[900],


                          ),




                          Image.asset('assets/conge.png', width: 250, height: 250,),
                        ],
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DemandeConge()),
                        );
                      },
                    ),
                  ),


                  Expanded(
                    child: IconButton(
                      icon: Stack(
                        children: [
                          Container(
                            width: 250,
                            height:250,
                            color: Colors.pink[900],


                          ),

                          Image.asset('assets/fichedepaie.png', width: 250, height: 250,),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageDemandeFichePaie()),
                        );
                      },
                    ),
                  ),
                  Expanded(child:
                  IconButton(
                    icon: Stack(
                      children :[
                        Container (
                          width:250,
                          height: 250,
                          color: Colors.red[900],
                        ),
                        Image.asset('assets/travail.png', width: 250, height: 250,),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DemandeAttestationTravailForm()));
                    },

                  ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(child:
                  IconButton(
                    icon: Stack(
                      children: [
                        Container(
                          width:250,
                          height: 250,
                          color: Colors.yellow[900],
                        ),




                        Image.asset('assets/credit.png', width:250, height: 250,),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DemandeAvanceForm()),
                      );
                    },
                  ),
                  ),
                  Expanded (child:
                  IconButton(
                    icon: Stack(
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          color: Colors.green[900],
                        ),
                        Image.asset('assets/modification.png', width: 250, height:250,),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DemandeModificationForm()),
                      );
                    },
                  ),
                  ),
                  Expanded(child:
                  IconButton(
                    icon: Stack(
                      children: [
                        Container(
                          width:250,
                          height:250,
                          color: Colors.brown[900],
                        ),
                        Image.asset('assets/tenu.png', width: 250, height: 250,),


                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DemandeTenuForm()),
                      );
                    },
                  ),
                  ),


                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Stack(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            color: Colors.yellowAccent,
                          ),
                          Image.asset(
                            'assets/transport.png',
                            width: 250,
                            height: 250,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DemandetransportForm()),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon:
                      Stack(
                        children:[
                          Container (
                            color: Colors.pink,
                            width: 250,
                            height: 250,
                          ),
                          Image.asset(
                            'assets/attsalaire.png',
                            width: 250,
                            height:250,

                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DemandeAttestationSalaireForm())
                        );
                      },
                    ),
                  ),
                  Expanded(

                    child: IconButton(
                      icon: Stack(
                        children:[
                          Container (
                            color: Colors.greenAccent,
                            width: 250,
                            height: 250,
                          ),

                          Image.asset(
                            'assets/reclamation.png',
                            width: 250,
                            height: 250,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reclamation()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),




        ),

      ),
    );

  }
}

