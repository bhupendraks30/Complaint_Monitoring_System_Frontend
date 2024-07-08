import 'dart:convert';

import 'package:complaint_monitoring_system/Activities/Main_Activity.dart';
import 'package:complaint_monitoring_system/ApiLink.dart';
import 'package:complaint_monitoring_system/UserDetails.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complain_Registration_From extends StatefulWidget {
  const Complain_Registration_From({super.key});

  @override
  State<Complain_Registration_From> createState() =>
      _Complain_Registration_FromState();
}

class _Complain_Registration_FromState
    extends State<Complain_Registration_From> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    distFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    pinCodeFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    getDataFromSharedPref();
  }

  // controller of NameTextField
  var nameController = TextEditingController();
  // Controller of Email TextField
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();
  var stateController = TextEditingController();
  var distController = TextEditingController();
  var cityController = TextEditingController();
  var pinCodeController = TextEditingController();
  var descriptionController = TextEditingController();
  // for email focusNode
  late FocusNode emailFocusNode;
  late FocusNode mobileFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode stateFocusNode;
  late FocusNode distFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode pinCodeFocusNode;
  late FocusNode descriptionFocusNode;

  // for email focusNode
  late FocusNode nameFocusNode;
  // used for error message
  String? emailStringError = null;
  String? mobileStringError = null;
  String? addressStringError = null;
  String? stateStringError = null;
  String? distStringError = null;
  String? cityStringError = null;
  String? pinCodeStringError = null;
  String? descriptionStringError = null;
// used for error name
  String? nameStringError = null;
  String? _selectedValue;
  //  create variable for sharedpref
  late final SharedPreferences? sharedPreferences;
  // variables for user data
  int uid=-1;
  var full_name;
  var email;
  var mobile_number;
  var state;
  var district;
  var pin_code;
  var address;
  // values for category
  final List<String> _dropdownItems = [
    'Land Records',
    'Public Distribution System',
    'Election',
    'Social Welfare',
    'Health Services',
    'Taxation',
    'Law and Order',
    'Education',
    'Public Transport',
    'Water Transport',
    'Water Supply',
    'Electricity',
    'Sanitation',
    'Environmental Issues',
    'Infrastructure',
    'Public',
    'Visitor',
    'General Inquiries',
    'Data Security',
    'Technical Issues'
  ];

  // get data from sharedprefrence
  void getDataFromSharedPref()async{
    sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      uid = sharedPreferences?.getInt(UserDetails.ID)??-1;
    });
  }


  // used to perform validation
  void checkValidationForEmail() {
    // for Email TextField
    bool isValidEmail = EmailValidator.validate(emailController.text.trim());
    if (!isValidEmail && !emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Please enter a valid email';
        emailFocusNode.requestFocus();
        return;
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Email field is empty';
        emailFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        emailStringError = null;
        emailFocusNode.unfocus();
      });
    }
  }

  // used to perform validation
  void checkValidationForName() {
    if (nameController.text.isEmpty) {
      setState(() {
        nameStringError = 'Name field is empty';
        nameFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        nameStringError = null;
        nameFocusNode.unfocus();
      });
    }
  }

  void checkValidationForMobile() {
    if (mobileController.text.isEmpty) {
      setState(() {
        mobileStringError = 'Mobile Number field is empty';
        mobileFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        mobileStringError = null;
        mobileFocusNode.unfocus();
      });
    }
  }

  void checkValidationForAddress() {
    if (addressController.text.isEmpty) {
      setState(() {
        addressStringError = 'Address field is empty';
        addressFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        addressStringError = null;
        addressFocusNode.unfocus();
      });
    }
  }

  void checkValidationForState() {
    if (stateController.text.isEmpty) {
      setState(() {
        stateStringError = 'State field is empty';
        stateFocusNode.requestFocus();
      });
    } else {
      setState(() {
        stateStringError = null;
        stateFocusNode.unfocus();
      });
    }
  }

  void checkValidationForDist() {
    if (distController.text.isEmpty) {
      setState(() {
        distStringError = 'District field is empty';
        distFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        distStringError = null;
        distFocusNode.unfocus();
      });
    }
  }

  void checkValidationForCity() {
    if (cityController.text.isEmpty) {
      setState(() {
        cityStringError = 'City field is empty';
        cityFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        cityStringError = null;
        cityFocusNode.unfocus();
      });
    }
  }

  void checkValidationForPinCode() {
    if (pinCodeController.text.isEmpty) {
      setState(() {
        pinCodeStringError = 'Pin Code field is empty';
        pinCodeFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        pinCodeStringError = null;
        pinCodeFocusNode.unfocus();
      });
    }
  }

  void checkValidationForDescription() {
    if (descriptionController.text.isEmpty) {
      setState(() {
        descriptionStringError = 'Description field is empty';
        descriptionFocusNode.requestFocus();
        return;
      });
    } else {
      setState(() {
        descriptionStringError = null;
        descriptionFocusNode.unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Grievance Registration",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                focusNode: nameFocusNode,
                onTapOutside: (event) {
                  checkValidationForName();
                },
                decoration: InputDecoration(
                  errorText: nameStringError,
                  label: Text(
                    "Full Name",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onTapOutside: (event) {
                  checkValidationForEmail();
                },
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  label: Text(
                    "Email",
                    style: TextStyle(color: Colors.black),
                  ),
                  errorText: emailStringError,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: mobileController,
                focusNode: mobileFocusNode,
                onTapOutside: (event) {
                  checkValidationForMobile();
                },
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  errorText: mobileStringError,
                  label: Text(
                    "Mobile Number",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: addressController,
                focusNode: addressFocusNode,
                onTapOutside: (event) {
                  checkValidationForAddress();
                },
                maxLength: 1000,
                maxLines: null,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: addressStringError,
                  labelText: 'Address',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  // used to decorate the focusedErrorBorder of Password TextField
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  // used to decorate the TextField when the it is enabled
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),

                  // used to decorate the TextField when the it is Focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),

                  // this contentPadding is used to set the height of the TextField
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: stateController,
                focusNode: stateFocusNode,
                onTapOutside: (event) {
                  checkValidationForState();
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: stateStringError,
                  label: Text(
                    "State",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: distController,
                focusNode: distFocusNode,
                onTapOutside: (event) {
                  checkValidationForDist();
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: distStringError,
                  label: Text(
                    "District",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: cityController,
                focusNode: cityFocusNode,
                onTapOutside: (event) {
                  checkValidationForCity();
                },
                decoration: InputDecoration(
                  errorText: cityStringError,
                  label: Text(
                    "City",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                controller: pinCodeController,
                focusNode: pinCodeFocusNode,
                onTapOutside: (event) {
                  checkValidationForPinCode();
                },
                decoration: InputDecoration(
                  errorText: pinCodeStringError,
                  label: Text(
                    "Pin code",
                    style: TextStyle(color: Colors.black),
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Grienvance Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      'Grievance Category : ',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton(
                      elevation: 12,
                      itemHeight: 50,
                      focusColor: Colors.lightBlueAccent,
                      iconEnabledColor: Colors.lightBlueAccent,
                      dropdownColor: Colors.lightBlue.shade50,
                      menuMaxHeight: 400,
                      borderRadius: BorderRadius.circular(12),
                      iconSize: 35,
                      alignment: Alignment.center,
                      value: _selectedValue,
                      hint: Text(
                        'Choose a category',
                        style: TextStyle(fontSize: 18),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                      items: _dropdownItems
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                focusNode: descriptionFocusNode,
                onTapOutside: (event) {
                  checkValidationForDescription();
                },
                maxLength: 1000,
                maxLines: null,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorText: descriptionStringError,
                  labelText: 'Grievance Description',
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  // used to decorate the focusedErrorBorder of Password TextField
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  // used to decorate the TextField when the it is enabled
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),

                  // used to decorate the TextField when the it is Focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.lightBlueAccent,
                    ),
                  ),

                  // this contentPadding is used to set the height of the TextField
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    checkValidationForName();
                    checkValidationForEmail();
                    checkValidationForMobile();
                    checkValidationForAddress();
                    checkValidationForState();
                    checkValidationForDist();
                    checkValidationForCity();
                    checkValidationForPinCode();
                    checkValidationForDescription();

                    if (_selectedValue != null && uid!=-1) {
                      var header = {'content-type': "application/json"};
                      var body = jsonEncode({
                          'uid':uid,
                        'full_name':nameController.text.toString().trim(),
                        'email':emailController.text.toString().trim(),
                        'mobile_number':mobileController.text.toString().trim(),
                        'state':stateController.text.toString(),
                        'district':distController.text.toString().trim(),
                        'address':addressController.text.toString().trim(),
                        'pin_code':pinCodeController.text.toString().trim(),
                        'category':_selectedValue,
                        'description':descriptionController.text.toString().trim(),
                        'city':cityController.text.toString().trim(),
                      });
                      final response = await post(Uri.parse(ApiLink.registerComplaint),headers: header,body: body);
                      var data = jsonDecode(response.body);
                      var code = data['code'];
                      if(code=='200'){
                        var message= data['message'];
                        Fluttertoast.showToast(msg: message);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Main_Activity(),));
                      }else{
                        Fluttertoast.showToast(msg: 'Please fill the form correctly');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      overlayColor: Colors.lightBlueAccent,
                      backgroundColor: Colors.lightBlueAccent),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
