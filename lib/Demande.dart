import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_stage/DemandeCredit.dart';
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
            "assets/logo.jpeg",
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
                          MaterialPageRoute(builder: (context) => DemandeCredit()),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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

