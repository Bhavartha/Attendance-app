import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SignUp.dart';
import 'FYCM.dart';
import 'SYCM.dart';
import 'TYCM.dart';
import 'UserHome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/HomePage': (context) => HomePage(false),
        'SignUp': (context) => Signup(),
        'UserHome': (context) => UserHome(),
        'TYCM': (context) => TYCM(),
        'SYCM': (context) => SYCM(),
        'FYCM': (context) => FYCM(),
      },
      home: HomePage(false),
      debugShowCheckedModeBanner: false,
      title: 'Attendance_App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool error;
  HomePage([this.error = false]);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool error;
  bool showpass = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void verifyLogin(String id, String pass) async {
    var result = await http.post("http://192.168.43.210/attendance/login.php",
        body: {"id": id, "pass": pass});
    print(result.body);
    if (result.body == "Login Successful")
      Navigator.of(context).pushReplacementNamed('UserHome');
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("login error"),
            content: new Text("user id or password incorrect"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Attendance App")),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(height: 30),
          Image.asset("assets/logo.png", width: 150, height: 150),
          SizedBox(height: 20),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: "Id_No", filled: true),
          ),
          SizedBox(height: 5),
          TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          showpass = !showpass;
                        });
                      })),
              obscureText: !showpass),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              RaisedButton(
                  color: Colors.yellowAccent,
                  child: Text("Submit"),
                  onPressed: () {
                    verifyLogin(
                        usernameController.text, passwordController.text);
                  }),
              SizedBox(width: 150),
              RaisedButton(
                color: Colors.lightBlueAccent,
                child: Text("Sign Up"),
                onPressed: () {
                  setState(() {
                    error = false;
                    usernameController.clear();
                    passwordController.clear();
                    Navigator.of(context).pushNamed('SignUp');
                  });
                },
              )
            ],
          )
        ])));
  }
}
