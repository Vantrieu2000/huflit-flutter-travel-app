import 'package:flutter/material.dart';
import 'package:travelink_app/screens/Login/Login_Page.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({Key? key}) : super(key: key);
  static String routeName = 'welcome_screen';

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/background.jpg", fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 40),
                    child: Text("TRAVELINK xin chào !",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text("Bắt đầu", style: TextStyle(fontSize: 18))),
                ),
              ]),
              height: 180,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(45, 44, 44, 0.6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36)))),
        )
      ],
    ));
  }
}
