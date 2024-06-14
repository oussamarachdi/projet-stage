import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'userModel.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  List<UserModels> userData = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot<List<UserModels>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return Column(
                children: [
                  Text('EEID: ${user.EEID}'),
                  Text('Full Name: ${user.fullName}'),
                  Text('Job Title: ${user.jobTitle}'),
                  Text('Department: ${user.Departement}'), // Corrected spelling
                  Text('Business Unit: ${user.businessUnit}'),
                  Text('Ethnicity: ${user.ethnicity}'),
                  Text('Age: ${user.Age}'),
                  Text('Hire Date: ${user.hireDate}'), // Corrected property name
                  Text('Bonus %: ${user.bonus}'),
                  Text('Country: ${user.country}'),
                  Text('City: ${user.city}'),
                  Text('Exit Date: ${user.exitDate}'), // Corrected property name
                ],
              );
            },
          );
        }
      },
    );
  }

  Future<List<UserModels>> getData() async {
    var uri = Uri.http("192.168.1.16:3000", "/excel/readExcel");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["message"] as List<dynamic>;
      print(data);
      userData = data.map((e) => UserModels.fromJson(e)).toList();
      return userData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}