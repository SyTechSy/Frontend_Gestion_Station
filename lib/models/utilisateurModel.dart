class UserModel {
  int? idUser;
  String? nomUtilisateur;
  String? prenomUtilisateur;
  String? emailUtilisateur;
  String? photoUrl;
  String? motDePasse;

  UserModel({
    this.idUser,
    this.nomUtilisateur,
    this.prenomUtilisateur,
    this.emailUtilisateur,
    this.photoUrl,
    this.motDePasse,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
   return UserModel(
     idUser : json['idUser'],
     nomUtilisateur: json['nomUtilisateur'],
     prenomUtilisateur: json['prenomUtilisateur'],
     emailUtilisateur : json['emailUtilisateur'],
     photoUrl : json['photoUrl'],
     motDePasse : json['motDePasse'],
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idUser': idUser,
      'nomUtilisateur': nomUtilisateur,
      'prenomUtilisateur': prenomUtilisateur,
      'emailUtilisateur': emailUtilisateur,
      'motDePasse': motDePasse,
      'photoUrl': photoUrl,
    };
    return data;
  }

/*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['nomUser'] = this.nomUser;
    data['prenomUser'] = this.prenomUser;
    data['emailUser'] = this.emailUser;
    data['photo'] = this.photo;
    data['motDePasseUser'] = this.motDePasseUser;
    return data;
  }*/
}