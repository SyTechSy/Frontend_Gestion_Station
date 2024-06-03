import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/models/budget_models.dart';

class EssencePage extends StatelessWidget {
  EssencePage({super.key});

  List<BudgetList> budgetList = BudgetList.budgetList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: budgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Transform.translate(
                  offset: Offset(0, -20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5 ,left: 15, right: 15),
                      width: double.infinity,
                      child: Card(
                        color: Color(0xFFDADADA),
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        "Budget obtenir par Amadou Guitteye",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10, right: 10),
                                    child: Text(
                                      budgetList[index].budgetObtenu,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff12343b),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.alarm,
                                            size: 12,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Mercredi le 29/05/2024",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Voir détails",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
    );
  }
}
