class BudgetTotalModel {
  int? idBudgetTotal;
  double budgetTotalEssence;
  double budgetTotalGasoil;
  double sommeTotalBudgets;
  double argentRecuTravail;
  double perteArgent;
  double gainArgent;
  DateTime dateAddBudgetTotal;
  int? idUser;
  String nomUtilisateur;
  String prenomUtilisateur;

  BudgetTotalModel ({
    required this.idBudgetTotal,
    required this.budgetTotalEssence,
    required this.budgetTotalGasoil,
    required this.sommeTotalBudgets,
    required this.argentRecuTravail,
    required this.perteArgent,
    required this.gainArgent,
    required this.dateAddBudgetTotal,
    required this.idUser,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
  });

  factory BudgetTotalModel.fromJson(Map<String, dynamic> json) {
    return BudgetTotalModel(
      idBudgetTotal: json['idBudgetTotal'] != null ? (json['idBudgetTotal'] is int ? json['idBudgetTotal'] : int.tryParse(json['idDevis'].toString())) : null,
      budgetTotalEssence: json['budgetTotalEssence'] != null ? (json['budgetTotalEssence'] as num).toDouble() : 0.0,
      budgetTotalGasoil: json['budgetTotalGasoil'] != null ? (json['budgetTotalGasoil'] as num).toDouble() : 0.0,
      sommeTotalBudgets: json['sommeTotalBudgets'] != null ? (json['sommeTotalBudgets'] as num).toDouble() : 0.0,
      argentRecuTravail: json['argentRecuTravail'] != null ? (json['argentRecuTravail'] as num).toDouble() : 0.0,
      perteArgent: json['perteArgent'] != null ? (json['perteArgent'] as num).toDouble() : 0.0,
      gainArgent: json['gainArgent'] != null ? (json['gainArgent'] as num).toDouble() : 0.0,
      dateAddBudgetTotal: json['dateAddBudgetTotal'] != null && json['dateAddBudgetTotal'] is Map<String, dynamic>
          ? DateTime.parse(json['dateAddBudgetTotal']['date'])
          : DateTime.now(),
      idUser: json['utilisateur'] != null ? (json['utilisateur']['id'] is int ? json['utilisateur']['id'] : int.tryParse(json['utilisateur']['id'].toString())) : null,
      nomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['nomUtilisateur'] : null,
      prenomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['prenomUtilisateur'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idBudgetTotal': idBudgetTotal,
      'budgetTotalEssence': budgetTotalEssence,
      'budgetTotalGasoil': budgetTotalGasoil,
      'sommeTotalBudgets': sommeTotalBudgets,
      'argentRecuTravail': argentRecuTravail,
      'perteArgent': perteArgent,
      'gainArgent': gainArgent,
      'dateAddBudgetTotal': dateAddBudgetTotal.toIso8601String(),
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
    };
  }
}