/*
import 'package:flutter/material.dart';

import 'essencePage.dart';
import 'gasoilPage.dart';

class NavBarSection extends StatefulWidget {
  const NavBarSection({super.key});

  @override
  State<NavBarSection> createState() => _NavBarSectionState();
}

class _NavBarSectionState extends State<NavBarSection> {
  int selectedIndex = 0;
  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.06,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: (selectedIndex == 0)
                            ? const Color.fromARGB(43, 76, 175, 79)
                            : Colors.transparent),
                    child: Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            minimumSize:
                            const Size(double.infinity, double.infinity)),
                        onPressed: () {
                          selectedPage(0);
                        },
                        child: const Text(
                          "Score",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: (selectedIndex == 1)
                            ? const Color.fromARGB(43, 76, 175, 79)
                            : Colors.transparent),
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Center(
                      child: TextButton(
                          style: TextButton.styleFrom(
                              minimumSize:
                              const Size(double.infinity, double.infinity)),
                          onPressed: () {
                            selectedPage(1);
                          },
                          child: const Text(
                            "Classement",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black.withOpacity(0.3),
            ),
            (selectedIndex == 0) ? const EssencePage() : const GasoilPage()
          ])),
    );
  }
}
*/