import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpd;

class Attendance extends StatefulWidget {
  final String _title;
  final List students;
  final String sub;
  final String date;
  Attendance(this.students, this.date, this.sub,this._title);
  @override
  _AttendanceState createState() => _AttendanceState(students,date,sub,_title);
}

class _AttendanceState extends State<Attendance> {
  List students;  
  String _title;
  String sub;
  String date;
  _AttendanceState(this.students, this.date, this.sub,this._title);

  void postAttendance(String date, String subject) async {
    String p_no="";
    print(students.length);
    students.forEach((s){if(s[2]=="true") p_no=p_no+s[0].toString()+"#";});
    print(p_no.toString());
    var result = await httpd.post(
        "http://192.168.43.210/attendance/save_attendance.php",
        body: {'date': date, 'subject': subject, 'p_no': p_no});
    print(result.body);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Successful"),
            content: new Text("Attendance recorded"),
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

  void changebool(bool value, int index) {
    students[index][2] =( value == true )? "true" : "false";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.send), onPressed: () {
              postAttendance(date, sub);
            })
          ],
          title: Text(_title),
        ),
        body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              value: students[index][2] == "true",
              onChanged: (bool value) {
                setState(() {
                  changebool(value, index);
                });
              },
              title: Text('${students[index][1].toString().replaceAll("?", "")}'),
            );
          },
        ));
  }
}
