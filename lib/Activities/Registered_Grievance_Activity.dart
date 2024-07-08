import 'dart:convert';

import 'package:complaint_monitoring_system/ApiLink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserDetails.dart';

class Registered_Grievance_Activity extends StatefulWidget {
  const Registered_Grievance_Activity({super.key});

  @override
  State<Registered_Grievance_Activity> createState() =>
      _Registered_Grievance_ActivityState();
}

class _Registered_Grievance_ActivityState
    extends State<Registered_Grievance_Activity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromSharedPref();
  }

  var listOfGrievance = [];
  late final SharedPreferences sharedPreferences;
  int uid = -1;
  var role = -1;

  // get data from sharedprefrence
  void getDataFromSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uid = sharedPreferences.getInt(UserDetails.ID) ?? -1;
      role = sharedPreferences.getInt(UserDetails.ROLE) ?? -1;
    });
    if(role!=-1) {
      String url = '';

      if (role == 0) {
        setState(() {
          url=ApiLink.getRegisteredGrievance;
        });
        var response = await post(Uri.parse(url),
            headers: {'content-type': 'application/json'},
            body: jsonEncode({'uid': uid}));
        var data = jsonDecode(response.body);
        setState(() {
          listOfGrievance = data['registered_complaints'];
        });
      } else {
        setState(() {
          url=ApiLink.getAllRegisteredGrievance;
        });
        var response = await get(Uri.parse(url));
        var data = jsonDecode(response.body);
        setState(() {
          listOfGrievance = data['registered_complaints'];
        });
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Grievance",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: double.infinity,
              mainAxisSpacing: 5,
              mainAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return GrievanceCardItem(listOfGrievance[index], role);
            },
            itemCount: listOfGrievance.length,
          ),
        ),
      ),
    );
  }
}

class GrievanceCardItem extends StatefulWidget {
  var dataList;
  var role;
  GrievanceCardItem(this.role, this.dataList, {super.key});

  @override
  State<GrievanceCardItem> createState() =>
      _GrievanceCardItemState(dataList, role);
}

class _GrievanceCardItemState extends State<GrievanceCardItem> {
  var dataList;
  var role;

  _GrievanceCardItemState(this.role, this.dataList);

  String? _selectedValue;

  var status = ['Pending', 'Approved', 'Reject'];
  bool visible=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _selectedValue=dataList['status'];
    });
  }


  @override
  Widget build(BuildContext context) {
    if(role==0){
      setState(() {
        visible=false;
      });
    }else{
      setState(() {
        visible=true;
      });
    }
    return Scaffold(
      body: Card(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Grievance Id :',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      dataList['cid'],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Grievance Category :',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      dataList['category'],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        'Grievance Description :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['description'],
                        style: TextStyle(color: Colors.white, fontSize: 18,),textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Grievance Register Date :',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      dataList['date_submitted'].toString().substring(0, 10),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Grievance Status :',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      dataList['status'],
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: visible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Set Grievance Status :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      DropdownButton(
                        elevation: 12,
                        itemHeight: 50,
                        focusColor: Colors.red.shade100,
                        iconEnabledColor: Colors.black,
                        dropdownColor: Colors.lightBlue.shade50,
                        menuMaxHeight: 400,
                        borderRadius: BorderRadius.circular(12),
                        iconSize: 35,
                        alignment: Alignment.center,
                        value: _selectedValue,
                        hint: Text(
                          'set status',
                          style: TextStyle(fontSize: 18),
                        ),
                        onChanged: (String? newValue) async{
                          setState(() {
                            _selectedValue = newValue;
                          });

                          var response = await post(
                              Uri.parse(ApiLink.updateGrievanceStatus),
                              headers: {'content-type': 'application/json'},
                              body: jsonEncode({
                                'cid': dataList['cid'],
                                'status':_selectedValue
                              }));
                          var data = jsonDecode(response.body);
                          if (data['code'] == '200') {
                            Fluttertoast.showToast(msg: data['message']);
                          } else {
                            Fluttertoast.showToast(msg: data['message']);
                          }

                        },
                        items: status
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
