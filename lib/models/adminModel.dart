class AdminModel {
  int? idAdmin;
  String? nomAdmin;
  String? prenomAdmin;
  String? emailAdmin;
  String? motDePasse;

  AdminModel({
    this.idAdmin,
    this.nomAdmin,
    this.prenomAdmin,
    this.emailAdmin,
    this.motDePasse,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      idAdmin: json['id'],
      nomAdmin: json['nomAdmin'],
      prenomAdmin: json['prenomAdmin'],
      emailAdmin: json['emailAdmin'],
      motDePasse: json['motDePasse'],
    );
  }

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = {
      'idAdmin': idAdmin,
      'nomAdmin': nomAdmin,
      'prenomAdmin': prenomAdmin,
      'emailAdmin': emailAdmin,
      'motDePasse': motDePasse,
    };
    return data;
  }
}