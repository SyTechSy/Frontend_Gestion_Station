import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import 'detailStationBons.dart';

class SectionStationBons extends StatefulWidget {
  const SectionStationBons({super.key});

  @override
  State<SectionStationBons> createState() => _SectionStationBonsState();
}

class _SectionStationBonsState extends State<SectionStationBons> {

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -30),
      child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                //final bons = bonStations[index];
                return Slidable(
                  endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.green,
                          onPressed: (context) async {},
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
                          builder: (context) => SectionDetailStationBons()
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            'Bon pour Samedi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            "Total : 50 000 Fcfa",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: Text(
                            "3",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
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
              }
          ),
      ),
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
