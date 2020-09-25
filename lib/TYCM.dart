import 'package:attendance/Attendance.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:http/http.dart' as http;

class TYCM extends StatefulWidget {
  @override
  _TYCMState createState() => _TYCMState();
}

class _TYCMState extends State<TYCM> {
  var subjects = [
    "Select Subject",
    "Advanced Java",
    "Software Testing",
    "Object Oriented Modelling and Designing",
    "Linux Programming",
    "Management",
    "Entrepreneurship"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String selected;
  String _date=DateTime.now().toString().substring(0, 10);
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    selected = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sub in subjects) {
      items.add(new DropdownMenuItem(value: sub, child: new Text(sub)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TYCM"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DropdownButton(
              value: selected,
              items: _dropDownMenuItems,
              onChanged: (choice) {
                setState(() {
                  selected = choice.toString();
                  print(selected);
                });
              },
            ),
            SizedBox(height: 25),
            Calendar(
              onDateSelected: (date) {
                setState(() {
                  _date = date.toString().substring(0, 10);
                  print(_date);
                });
              },
              isExpandable: true,
            ),
            SizedBox(height: 45),
            Row(children: <Widget>[
              SizedBox(width: 25),
              RaisedButton(
                child: Text("CM1"),
                onPressed: () async {
                  var tablename = "cm_2016-17";
                  var result = await http.post(
                      "http://192.168.43.210/attendance/get_students.php",
                      body: {"tablename": tablename});
                  var _ = [];
                  result.body
                      .substring(
                        1,
                      )
                      .split('%')
                      .forEach((f) {
                    _.add(f.split('#'));
                  });
                  if (selected!="Select Subject") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Attendance(_, _date, selected,"TYCM1")));
                  } else {
                    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Select Subject"),
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
                  
                },
              ),
              SizedBox(width: 125),
              RaisedButton(
                child: Text("CM2"),
                onPressed: () async {
                  var tablename = "cm2_2016-17";
                  var result = await http.post(
                      "http://192.168.43.210/attendance/get_students.php",
                      body: {"tablename": tablename});
                  var _ = [];
                  result.body
                      .substring(
                        1,
                      )
                      .split('%')
                      .forEach((f) {
                    _.add(f.split('#'));
                  });
                  // print(_);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Attendance(_, _date, selected,"TYCM2")));
                },
              )
            ]),
            SizedBox(height: 55),
          ],
        ),
      ),
    );
  }
}
