import 'dart:convert';

List<UserModels> userModelsFromJson(String str) =>
    List<UserModels>.from(json.decode(str).map((x) => UserModels.fromJson(x)));

String userModelsToJson(List<UserModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModels {
  String EEID;
  String fullName;
  String jobTitle;
  String Departement;
  String businessUnit;
  String gender;
  String ethnicity;
  int Age;
  int hireDate;
  int annualSalary;
  double bonus;
  String country;
  String city;
  int exitDate;

  UserModels({
    required this.EEID,
    required this.fullName,
    required this.jobTitle,
    required this.Departement,
    required this.businessUnit,
    required this.gender,
    required this.ethnicity,
    required this.Age,
    required this.hireDate,
    required this.annualSalary,
    required this.bonus,
    required this.country,
    required this.city,
    required this.exitDate,
  });
// `toJson` converts a UserModels object to a JSON representation.
// `fromJson` creates a UserModels object from a JSON map.

  factory UserModels.fromJson(Map<String, dynamic> json) => UserModels(
    EEID: json["EEID"],
    fullName: json["Full Name"],
    jobTitle: json["Job Title"],
    Departement: json["Department"],
    businessUnit: json["Business Unit"],
    gender: json["Gender"],
    ethnicity: json["Ethnicity"],
    Age: json["Age"],
    hireDate: json["Hire Date"],
    annualSalary: json["Annual Salary"],
    bonus: json["Bonus %"].toDouble(),
    country: json["Country"],
    city: json["City"],
    exitDate: json["Exit Date"],
  );

  Map<String, dynamic> toJson() => {
    "EEID": EEID,
    "Job Title": fullName,
    "Department": Departement,
    "Business Unit": businessUnit,
    "Gender": gender,
    "Ethnicity": ethnicity,
    "Age": Age,
    "Hire Date": hireDate,
    "Annual Salary": annualSalary,
    "Bonus %": bonus,
    "Country": country,
    "City": city,
    "Exit Date": exitDate,
  };
}
