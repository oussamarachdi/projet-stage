import 'package:flutter/material.dart';
import 'package:projet_stage/ConsulterDemande.dart';
import 'package:projet_stage/Test.dart';
import 'package:projet_stage/followup.dart';
import 'package:projet_stage/rapport.dart';
import 'package:projet_stage/reclamation.dart';


class Home extends StatefulWidget {
  final String pos;
  const Home({super.key, required this.pos});



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: const Icon(Icons.account_balance, color: Colors.white, size: 32),
              label: const Text(
                "Suivi",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowUp()));
              },
            ),
            // TEST
            ElevatedButton.icon(
              icon: const Icon(Icons.account_balance, color: Colors.white, size: 32),
              label: const Text(
                "Test",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Consulterdemande()));
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: const Icon(Icons.accessibility, color: Colors.white, size: 32),
              label: const Text(
                "Demande",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: const Size(300, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Reclamation()));
              },
            ),
            const SizedBox(height: 50),
            Visibility(
              visible: widget.pos != "operateur" ? true : false,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.access_time_rounded, color: Colors.white, size: 32),
                label: const Text(
                  "Rapport",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  minimumSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: const BorderSide(color: Colors.white, width: 1),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const rapport()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

