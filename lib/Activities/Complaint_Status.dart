import 'dart:convert';

import 'package:complaint_monitoring_system/Activities/Complaint_Details_Activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLink.dart';
import '../UserDetails.dart';

class Complaint_Status extends StatefulWidget {
  const Complaint_Status({super.key});

  @override
  State<Complaint_Status> createState() => _Complaint_Status_State();
}

class _Complaint_Status_State extends State<Complaint_Status> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cidFocuseNode = new FocusNode();
  }

  var cid = TextEditingController();
  late FocusNode cidFocuseNode;
  String? cidErrorString = null;
  late SharedPreferences sharedPreferences;
  int uid = -1;
  var complaintDetails;

  void checkValidationForCid() {
    if (cid.text.isEmpty) {
      cidErrorString = 'Please Enter the Complaint Id';
      cidFocuseNode.requestFocus();
      return;
    } else {
      cidErrorString = null;
      cidFocuseNode.unfocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 10,
          child: Container(
            width: 330,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Grievance Status',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cid,
                    focusNode: cidFocuseNode,
                    onTapOutside: (event) => checkValidationForCid,
                    style: TextStyle(color: Colors.white),
                    maxLength: 12,
                    decoration: InputDecoration(
                      label: Text(
                        'Enter Grievance Id',
                        style: TextStyle(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      errorText: cidErrorString,
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    cursorColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      checkValidationForCid();
                      if(!cid.text.isEmpty) {
                        sharedPreferences =
                            await SharedPreferences.getInstance();
                        setState(() {
                          uid = sharedPreferences.getInt(UserDetails.ID) ?? -1;
                        });
                        var response = await post(
                            Uri.parse(ApiLink.getGrievanceDetails),
                            headers: {'content-type': 'application/json'},
                            body: jsonEncode({
                              'uid': uid,
                              'cid': cid.text.toString().trim()
                            }));
                        var data = jsonDecode(response.body);
                        if (data['code'] == '200') {
                          print('${data['complaint_details'][0]}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Complaints_Details_Activity(
                                        data['complaint_details'][0]),
                              ));
                        } else {
                          Fluttertoast.showToast(msg: data['message']);
                        }
                      }else{
                        checkValidationForCid();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade700,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ));
  }
}
