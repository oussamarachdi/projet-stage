class User {
  final String matricule;
  final String password;
  final String pos;
  final String NP;
  final String fctSAP;
  final String contreMaitre;

  User({
    required this.matricule,
    required this.password,
    required this.pos,
    required this.NP,
    required this.fctSAP,
    required this.contreMaitre,
  });

  Map<String, dynamic> toJson() => {
    'matricule': matricule,
    'password': password,
    'pos': pos,
    'NP': NP,
    'fctSAP': fctSAP,
    'contreMaitre': contreMaitre,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      matricule: json['matricule'],
      password: json['password'],
      pos: json['pos'],
      NP: json['NP'],
      fctSAP: json['fctSAP'],
      contreMaitre: json['contreMaitre'],
    );
  }
}
