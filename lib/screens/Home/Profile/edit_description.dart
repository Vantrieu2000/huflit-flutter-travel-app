import 'package:flutter/material.dart';
import 'package:travelink_app/utils/user/user_data.dart';
import 'package:travelink_app/widgets/appbar_widget.dart';

// This class handles the Page to edit the About Me Section of the User Profile.
class EditDescriptionFormPage extends StatefulWidget {
  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
    user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: 350,
                      child: const Text(
                        "Bạn là kiểu người\nnhư thế nào?",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                          height: 250,
                          width: 350,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 100) {
                                return 'Hãy tự giới thiệu bản thân của mình ( nhiều hơn 100 từ )';
                              }
                              return null;
                            },
                            controller: descriptionController,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 100),
                                hintMaxLines: 3,
                                hintText:
                                    'Giới thiệu đôi chút về bản thân. Bạn có thích chat ? Bạn có hút thuốc? Bạn có mang thú cưng đi theo? ...'),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 350,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  updateUserValue(descriptionController.text);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Cập nhật',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )))
                ]),
          ),
        ));
  }
}
