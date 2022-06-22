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
                          style: TextStyle(fontSize: 18, color: Colors.white))),
                  Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10, 10, 10, 10),
                          child: TextFormField(
                            autofocus: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'Tên đăng nhập',
                              hintText: 'Tên người dùng',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF5F5F5),
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            autofocus: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'Mật khẩu',
                              hintText: '********',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                  bottomLeft: Radius.circular(4.0),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF5F5F5),
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 20),
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
