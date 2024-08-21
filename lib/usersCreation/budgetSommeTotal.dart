import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'detailBudgetSommeTotal.dart';

class BudgetSommeTotal extends StatefulWidget {
  const BudgetSommeTotal({super.key});

  @override
  State<BudgetSommeTotal> createState() => _BudgetSommeTotalState();
}

class _BudgetSommeTotalState extends State<BudgetSommeTotal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[350],
        title: Row(
          children: [
            Text(
              "Calculer la somme totale",
              style: TextStyle(
                color: Color(0xff12343b),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Total budget essence",
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      suffixIconConstraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Total budget gasoil",
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "L'argent reçu",
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                            color: Colors.white, letterSpacing: 1, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff12343b),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Votre budgets créer",
              style: TextStyle(
                  color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListBudgetSommeTotal(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListBudgetSommeTotal extends StatefulWidget {
  const ListBudgetSommeTotal({super.key});

  @override
  State<ListBudgetSommeTotal> createState() => _ListBudgetSommeTotalState();
}

class _ListBudgetSommeTotalState extends State<ListBudgetSommeTotal> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.green,
                  onPressed: (context) {},
                  icon: Icons.edit,
                  label: 'Modifier',
                ),
                SlidableAction(
                  backgroundColor: Colors.red,
                  onPressed: (context) {},
                  icon: Icons.delete,
                  label: 'Supprimer',
                ),
              ]),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailBudgetSommeTotal()
              ));
            },
            child: Column(
              children: [
                ListTile(
                  /*leading: Container(
                    height: 50,
                    width: 50,
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/logo/profillllllll.png"
                      ),
                    ),
                  ),*/
                  title: Transform.translate(
                    offset: Offset(-8, 0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      'SY Diakaridia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-8, 0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      'Vendredi',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '580 250 XOP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '-750 XOP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text('||'),
                          const SizedBox(width: 5),
                          Text(
                            '+0 XOP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.1)))
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Color(0xff12343b),
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
}
