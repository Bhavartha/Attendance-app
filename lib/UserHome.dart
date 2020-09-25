import 'package:flutter/material.dart';

// import 'main.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Page'),
        ),
        body: Column(children: [
          Expandablelist(),
          SizedBox(height: 50),
          Text("Login Successful"),
          Center(
            child: RaisedButton(
                child: Text("Logout"),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                }),
          )
        ]));
  }
}

class Expandablelist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text("CM"), children: [
      ListTile(
        onTap: (){
           Navigator.of(context).pushNamed('FYCM');
        },
        title: Text("FY")
      ),ListTile(
        title: Text("SY"),
        onTap: (){
          Navigator.of(context).pushNamed('SYCM');
        },
      ),ListTile(
        title: Text("TY"),
        onTap: (){
          Navigator.of(context).pushNamed('TYCM');
        },
      )
    ]);
  }
}
