import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PageHeaderVerifEmail extends StatelessWidget {
  const PageHeaderVerifEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: PageVerifCodePourChangerPassword(),
            ),
          ),
        ],
      ),
    );
  }
}


class PageVerifCodePourChangerPassword extends StatefulWidget {
  const PageVerifCodePourChangerPassword({super.key});

  @override
  State<PageVerifCodePourChangerPassword> createState() => _PageVerifCodePourChangerPasswordState();
}

class _PageVerifCodePourChangerPasswordState extends State<PageVerifCodePourChangerPassword> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black
      ),
      decoration: BoxDecoration(
        color: Color(0xff12343b).withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      )
    );
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vérifie ton adresse e-mail",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),

          Text(
            "Entrer votre code qui vous a été envoyé sur ",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400
            ),
          ),

          Text(
            "s***38@gmail.com",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              letterSpacing: 1
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Pinput(
              length: 5,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.green)
                ),
              ),
              onCompleted: (pin) => debugPrint(pin),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Renvoyer le code ",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "60s",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
