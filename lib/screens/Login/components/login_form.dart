// ignore: file_names
import 'package:flutter/material.dart';
import 'package:travelink_app/screens/Home/root.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/background.jpg", fit: BoxFit.cover),
        ),
        Center(
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                child: Column(children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 70),
                      child: Text(
                          "Cùng trải nghiệm những điều tuyệt vời bằng cách đăng nhập",
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, RootApp.routeName);
                        },
                        child: const Text("Đăng nhập",
                            style: TextStyle(fontSize: 18))),
                  ),
                ]),
                height: 360,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(45, 44, 44, 0.6),
                    borderRadius: BorderRadius.all(Radius.circular(36)))),
          ),
        )
      ],
    ));
  }
}
