import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_stage/DemandeConge.dart';
import 'package:projet_stage/DemandeFichePaie.dart';
import 'package:projet_stage/ficheDePaie.dart';
class PageDemande extends StatelessWidget {
  const PageDemande ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[ Image.asset(
            "assets/logo.png",
            width: 150,
            height: 150,
          ),
        ],
        ),
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
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Travail1()),
    );

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




                  Image.asset('assets/avance.png', width:250, height: 250,),
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
                    onPressed: () {

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
class DemandeCongePage extends StatefulWidget {
  const DemandeCongePage({Key? key}) : super(key: key);

  @override
  _DemandeCongePageState createState() => _DemandeCongePageState();
}

class _DemandeCongePageState extends State<DemandeCongePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  int? _numberOfDays;
  String _reason = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demande de Congé'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Date de début'),
              onTap: () {
                _selectDate(context);
              },
              trailing: _startDate != null
                  ? Text(_startDate!.toString())
                  : const Text('Choisir une date'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre de jours'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _numberOfDays = int.tryParse(value ?? '');
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Raison'),
              onSaved: (value) {
                _reason = value ?? '';
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Envoyer les données à votre backend ou traiter les données ici
                  }
                }
              },
              child: const Text('Soumettre'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _startDate = pickedDate;
        });
      }
    });
  }
}

