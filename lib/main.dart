import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LEONI'),
    );
  }
}
class User {
  final String martricule;
  final String password;

  User({required this.martricule, required this.password});
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
    User(martricule: "10234567", password: "admin"),
    User(martricule: "10345678", password: "admin"),
    User(martricule: "10123456", password: "admin"),
    User(martricule: "10298765", password: "admin"),
    User(martricule: "10387654", password: "admin"),
    User(martricule: "10176543", password: "admin"),
    User(martricule: "10212345", password: "admin"),
    User(martricule: "10323456", password: "admin"),
    User(martricule: "10134567", password: "admin"),
    User(martricule: "10245678", password: "admin")
  ];

  int indexUser(String matricule){
    for(int i=0; i<users.length; i++){
      if(users[i].martricule == matricule){
        return i;
      }
    }
    return -1;
  }

  bool passwordMatch(String pass, int ind){
    if(users[ind].password == pass){
      return true;
    }

    return false;
  }

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(key: _formKey,
            child: Column(


              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                const SizedBox(height: 50,),
                Padding(

                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Matriucle',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
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
                      if (value == null || value.isEmpty){
                        return 'Please enter your Password';
                      }
                      if (value.length != 5) {
                        return 'Password must be 5 digits long';
                      }
                      _password = value;
                      },

                    )),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int ind = indexUser(_matricule);
                        if (ind == -1) {
                          // Show error message for matricule not found
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Can't find your matricule in our database",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              ), backgroundColor: Colors.red,),
                          );
                        } else if (!passwordMatch(_password, ind)) {
                          // Show error message for incorrect password
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Incorrect Password'), backgroundColor: Colors.red,),
                          );
                        } else {
                          // Navigate to Home screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Home()),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                )



              ],
            )),
      ),
    );
  }
}