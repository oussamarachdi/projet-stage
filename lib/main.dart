// main.dart
import 'package:flutter/material.dart';
import 'package:projet_stage/user.dart';
import 'package:projet_stage/user_preferences.dart';

import 'home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LEONI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _matricule;
  late String _password;
  final _formKey = GlobalKey<FormState>();
  final List<User> users = [
    User(
        matricule: "10234567",
        password: "admin",
        pos: "operateur",
        NP: "Oussama Rachdi",
        fctSAP: "Chef Segment",
        contreMaitre: "Imen"),
    User(
        matricule: "10123456",
        password: "admin",
        pos: "operateur",
        NP: "Siwar Ajmi",
        fctSAP: "Chef Segment",
        contreMaitre: "Imen"),
  ];

  int indexUser(String matricule) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].matricule == matricule) {
        return i;
      }
    }
    return -1;
  }

  bool passwordMatch(String pass, int ind) {
    return users[ind].password == pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset("assets/logo.jpeg", width: 150, height: 150),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Matricule',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your matricule';
                    }
                    if (value.length != 8) {
                      return 'Matricule must be 8 digits long';
                    }
                    if (!value.startsWith('102') &&
                        !value.startsWith('101') &&
                        !value.startsWith('103')) {
                      return 'Matricule must start with 102, 101, or 103';
                    }
                    _matricule = value;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    if (value.length != 5) {
                      return 'Password must be 5 digits long';
                    }
                    _password = value;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int ind = indexUser(_matricule);
                      if (ind == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Can't find your matricule in our database",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (!passwordMatch(_password, ind)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Incorrect Password'),
                              backgroundColor: Colors.red),
                        );
                      } else {
                        await UserPreferences.saveUser(users[ind])
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home(pos: users[ind].pos)),
                          );
                        });
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
