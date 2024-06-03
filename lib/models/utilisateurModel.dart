class UserModel {
  int? idUser;
  String? nomUser;
  String? prenomUser;
  String? emailUser;
  String? photo;
  String? motDePasseUser;

  UserModel({
    this.idUser,
    this.nomUser,
    this.prenomUser,
    this.emailUser,
    this.photo,
    this.motDePasseUser,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    nomUser = json['nomUser'];
    prenomUser = json['prenomUser'];
    emailUser = json['emailUser'];
    photo = json['photo'];
    motDePasseUser = json['motDePasseUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['nomUser'] = this.nomUser;
    data['prenomUser'] = this.prenomUser;
    data['emailUser'] = this.emailUser;
    data['photo'] = this.photo;
    data['motDePasseUser'] = this.motDePasseUser;
    return data;
  }
}