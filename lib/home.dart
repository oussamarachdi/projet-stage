import 'package:flutter/material.dart';
import 'package:projet_stage/followup.dart';
import 'package:projet_stage/rapport.dart';
import 'package:projet_stage/reclamation.dart';



class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String pos = "operateur";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Image.asset(
            "assets/logo.jpeg",
            width: 150,
            height: 150,
          ),
        ),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const followup()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const reclamation()));
              },
            ),
            const SizedBox(height: 50),
            Visibility(
              visible: pos != "operateur" ? true : false,
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
