import 'dart:convert';
import 'package:curd_sql_new/update_record.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class view_data extends StatefulWidget {
  const view_data({super.key});

  State<view_data> createState() => _view_dataState();
}

class _view_dataState extends State<view_data> {
  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      String uri = "http://idshipping.in/practise_api/delete_data.php";
      var res = await http.post(Uri.parse(uri), body: {"id": id});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Record Deleted");
        getrecord();
      } else {
        print("Some Issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    String uri = "http://idshipping.in/practise_api/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Data")),
      body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => update_record(
                                userdata[index]["uname"],
                                userdata[index]["uemail"],
                                userdata[index]["upassword"],
                              )));
                },
                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.red,
                ),
                title: Text(userdata[index]["uname"]),
                subtitle: Text(userdata[index]["uemail"]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    delrecord(userdata[index]["uid"]);
                  },
                ),
              ),
            );
          }),
    );
  }
}
