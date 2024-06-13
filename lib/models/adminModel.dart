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

  AdminModel.fromJson(Map<String, dynamic> json) {
    idAdmin = json['idAdmin'];
    nomAdmin = json['nomAdmin'];
    prenomAdmin = json['prenomAdmin'];
    emailAdmin = json['emailAdmin'];
    motDePasse = json['motDePasse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAdmin'] = this.idAdmin;
    data['nomAdmin'] = this.nomAdmin;
    data['prenomUser'] = this.prenomAdmin;
    data['emailAdmin'] = this.emailAdmin;
    data['motDePasse'] = this.motDePasse;
    return data;
  }
}