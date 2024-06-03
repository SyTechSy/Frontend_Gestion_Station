import 'package:flutter/material.dart';

class GasoilPage extends StatelessWidget {
  const GasoilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
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
                            "Budget obtenir par Amara Diagaby",
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
                          "593400 FCFA",
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
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
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
                            "Budget obtenir par Amara Diagaby",
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
                          "593400 FCFA",
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
    );
  }
}
