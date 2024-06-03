class BudgetList {
  final int idBudget;
  final double valeurArriver;
  final double valeurDepart;
  final double prixUniter;
  final double consomation;
  final String budgetObtenu;

  BudgetList({
    required this.idBudget,
    required this.valeurArriver,
    required this.valeurDepart,
    required this.prixUniter,
    required this.consomation,
    required this.budgetObtenu,
  });

  static List<BudgetList> budgetList = [
    BudgetList(
        idBudget: 1,
        valeurArriver: 255690,
        valeurDepart: 255000,
        prixUniter: 860,
        consomation: 690,
        budgetObtenu: "593400"
    ),
    BudgetList(
        idBudget: 2,
        valeurArriver: 129266,
        valeurDepart: 129134,
        prixUniter: 860,
        consomation: 132,
        budgetObtenu: "113520"
    ),
  ];
}