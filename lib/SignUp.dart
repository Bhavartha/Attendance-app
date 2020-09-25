import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final id = TextEditingController();
  var pass = TextEditingController();
  bool showpass = false;
  bool showrepass = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  void post(String id, String pass) async {
    var result = await http.post("http://192.168.43.210/attendance/register.php",
        body: {"id": id, "pass": pass});
    print(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please type id_no';
                    }
                  },
                  controller: id,
                  decoration: InputDecoration(labelText: 'idno.'),
                ),
                TextFormField(
                  key: passKey,
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Your password needs to be atleast 6 characters';
                    }
                  },
                  controller: pass,
                  decoration: InputDecoration(
                      labelText: 'password',
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              showpass = !showpass;
                            });
                          })),
                  obscureText: !showpass,
                ),
                TextFormField(
                  obscureText: !showrepass,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              showrepass = !showrepass;
                            });
                          })),
                  validator: (input) {
                    if (passKey.currentState.value != input) {
                      return 'Passwords do not match';
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Sign in'),
                  onPressed: () {
                    signIn();
                  },
                )
              ],
            ),
          ),
        ));
  }

  String message() => "hello";

  void signIn() {
    final formstate = _formKey.currentState;
    if (formstate.validate()) {
      print('sign in');
      post(id.text, pass.text);
      Navigator.pop(context);
    }
  }
}
