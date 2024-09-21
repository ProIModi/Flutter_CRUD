//import 'dart:convert';
import 'dart:convert';
import 'package:curd_sql_new/view_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    Future<void> insertrecord() async {
      if (name.text != "" || email.text != "" || password.text != "") {
        try {
          //http://127.0.0.1/practise_api/insert_record.php
          //String uri = "http://127.0.0.1/practise_api/insert_record.php";
          String uri = "http://idshipping.in/practise_api/insert_record.php";
          var res = await http.post(Uri.parse(uri), headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST, GET, PUT, DELETE"
          }, body: {
            "name": name.text,
            "email": email.text,
            "password": password.text
          });

          var response = jsonDecode(res.body);
          print(response);
          if (response["success"] == "true") {
            print("Record Inserted");
          } else {
            print("Some Issueeee...");
          }
        } catch (e) {
          print(e);
        }
      } else {
        print("Please Fill All Fields");
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Insert Record'),
        ),
        body: Column(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter the Name')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Enter the Email')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter the Password')),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                insertrecord();
              },
              child: Text('Insert'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => view_data()));
                    },
                    child: Text("View Data"));
              },
            ),
          )
        ]),
      ),
    );
  }
}
