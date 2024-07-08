import 'dart:convert';
import 'dart:io';

import 'package:complaint_monitoring_system/Activities/Login_Activity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../ApiLink.dart';

class Registration_Form extends StatefulWidget {
  @override
  _Registration_FormState createState() => _Registration_FormState();
}

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class _Registration_FormState extends State<Registration_Form> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordFocusNode2 = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    distFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    pinCodeFocusNode = FocusNode();
  }

  XFile? selectImageXFile;

  // image File for profile that is converted from image xFile  to File type
  dynamic selectImageFile;

  // used for error message
  String? emailStringError = null;

  // used for error message
  String? passworStringError = null;

  // used for error name
  String? nameStringError = null;

  // used for error re-enter password
  String? passworStringError2 = null;

  String? mobileStringError = null;
  String? addressStringError = null;
  String? stateStringError = null;
  String? distStringError = null;
  String? cityStringError = null;
  String? pinCodeStringError = null;

  // for email focusNode
  late FocusNode emailFocusNode;

  // for email focusNode
  late FocusNode nameFocusNode;

  // for email focusNode
  late FocusNode passwordFocusNode;

  // for password focusNode
  late FocusNode passwordFocusNode2;
  late FocusNode mobileFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode stateFocusNode;
  late FocusNode distFocusNode;
  late FocusNode cityFocusNode;
  late FocusNode pinCodeFocusNode;

  // Controller of Email TextField
  var emailController = TextEditingController();

  // controller of Password TextField
  var passwordController = TextEditingController();

  // controller of re-enter Password TextField
  var passwordController2 = TextEditingController();

  // controller of NameTextField
  var nameController = TextEditingController();

  var mobileController = TextEditingController();
  var addressController = TextEditingController();
  var stateController = TextEditingController();
  var distController = TextEditingController();
  var cityController = TextEditingController();
  var pinCodeController = TextEditingController();

  // used to perform validation
  void checkValidationForEmail() {
    // for Email TextField
    bool isValidEmail = EmailValidator.validate(emailController.text.trim());
    if (!isValidEmail && !emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Please enter a valid email';
        emailFocusNode.requestFocus();
      });
      return;
    } else if (emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Email field is empty';
        emailFocusNode.requestFocus();
      });
      return;
    } else {
      setState(() {
        emailStringError = null;
        emailFocusNode.unfocus();
      });
      return;
    }
  }

  // used to perform validation
  void checkValidationForName() {
    if (nameController.text.isEmpty) {
      setState(() {
        nameStringError = 'Name field is empty';
        nameFocusNode.requestFocus();
      });
      return;
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
      });
      return;
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
      });
      return;
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
      return;
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
      });
      return;
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
      });
      return;
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
      });
      return;
    } else {
      setState(() {
        pinCodeStringError = null;
        pinCodeFocusNode.unfocus();
      });
    }
  }

  // validation For password
  void checkValidationForPassword() {
    if (!(passwordController.text.length >= 8) &&
        !passwordController.text.isEmpty) {
      setState(() {
        passworStringError = 'Please enter a password of at least 8 character';
        passwordFocusNode.requestFocus();
      });
      return;
    } else if (passwordController.text.isEmpty) {
      setState(() {
        passworStringError = 'Password field is empty';
        passwordFocusNode.requestFocus();
      });
      return;
    } else {
      setState(() {
        passworStringError = null;
        passwordFocusNode.unfocus();
      });
    }
  }

  // validation For re-enter password
  void checkValidationForPassword2() {
    if (!(passwordController2.text.trim() == passwordController.text.trim()) &&
        !passwordController2.text.isEmpty) {
      setState(() {
        passworStringError2 = 'Does not match !';
        passwordFocusNode2.requestFocus();
      });
      return;
    } else if (passwordController2.text.isEmpty) {
      setState(() {
        passworStringError2 = 'Re-enter password field is empty';
        passwordFocusNode.requestFocus();
      });
      return;
    } else {
      setState(() {
        passworStringError2 = null;
      });
    }
  }

  void imagePickerMethod(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      selectImageXFile = pickedImage;
    });
    if (selectImageXFile != null) {
      File selectedImageFile = File(selectImageXFile!.path);
      setState(() {
        selectImageFile = selectedImageFile;
      });
    } else {
      print("Empty file");
    }
  }

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade400,
                child: ClipRRect(
                  child: selectImageFile == null
                      ? Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white,
                        )
                      : Image.file(
                          selectImageFile!,
                          fit: BoxFit.cover,
                          height: 155,
                          width: 155,
                        ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => optionForCamerAndGalley(),
                );
              },
            ),
            SizedBox(height: 10.0),
            TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              onTapOutside: (event) {
                checkValidationForName();
              },
              focusNode: nameFocusNode,
              decoration: InputDecoration(
                label: Text(
                  "Full Name",
                  style: TextStyle(color: Colors.black),
                ),
                errorText: nameStringError,
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
            SizedBox(height: 10.0),
            TextField(
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
            SizedBox(
              height: 10,
            ),
            TextField(
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
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Gender:'),
                SizedBox(width: 10.0),
                Radio<String>(
                  value: "Male",
                  activeColor: Colors.lightBlueAccent,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.lightBlueAccent,
                  ),
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.blue.shade50,
                  ),
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Male'),
                SizedBox(width: 10.0),
                Radio<String>(
                  value: "Female",
                  activeColor: Colors.lightBlueAccent,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.lightBlueAccent,
                  ),
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.blue.shade50,
                  ),
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Female'),
                SizedBox(width: 10.0),
                Radio(
                  value: "Other",
                  activeColor: Colors.lightBlueAccent,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.lightBlueAccent,
                  ),
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.blue.shade50,
                  ),
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                Text('Other'),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
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
            SizedBox(height: 10.0),
            TextField(
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
            SizedBox(height: 10.0),
            TextField(
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
            SizedBox(height: 10.0),
            TextField(
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
            SizedBox(height: 10.0),
            TextField(
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
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              onTapOutside: (event) {
                checkValidationForPassword();
              },
              focusNode: passwordFocusNode,
              decoration: InputDecoration(
                label: Text(
                  "Set your password",
                  style: TextStyle(color: Colors.black),
                ),
                errorText: passworStringError,
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
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: true,
              controller: passwordController2,
              onTapOutside: (event) {
                checkValidationForPassword2();
              },
              focusNode: passwordFocusNode2,
              decoration: InputDecoration(
                label: Text(
                  "Re-enter your password",
                  style: TextStyle(color: Colors.black),
                ),
                errorText: passworStringError2,
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
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                // Handle form submission
                checkValidationForName();
                checkValidationForEmail();
                checkValidationForMobile();
                checkValidationForAddress();
                checkValidationForState();
                checkValidationForDist();
                checkValidationForCity();
                checkValidationForPinCode();
                checkValidationForPassword();
                checkValidationForPassword2();

                if (selectedGender!=null&&!nameController.text.isEmpty && !emailController.text.isEmpty && !mobileController.text.isEmpty && !addressController.text.isEmpty && !stateController.text.isEmpty && !distController.text.isEmpty && !cityController.text.isEmpty && !pinCodeController.text.isEmpty && !passwordController.text.isEmpty) {
                  try {

                    final request = await MultipartRequest(
                        'POST', Uri.parse(ApiLink.userRegistrationApi));

                    if (selectImageFile != null) {
                      request.files.add(await MultipartFile.fromPath(
                          'image', selectImageXFile!.path));
                    }

                    request.fields.addAll({
                      'full_name':nameController.text.toString()
                      , 'email':emailController.text.toString()
                      , 'mobile_number':mobileController.text.toString()
                      , 'gender':selectedGender ??''
                      , 'state':stateController.text.toString()
                      , 'district':distController.text.toString()
                      , 'city':cityController.text.toString()
                      , 'address':addressController.text.toString()
                      , 'pin_code':pinCodeController.text.toString()
                      , 'password':passwordController2.text.toString()
                      , 'role': '0',
                    });

                    final response = await request.send();
                    final responseString =
                        await response.stream.bytesToString();
                    final data = jsonDecode(responseString);

                    // extracting the response data
                    final code = data['code'];
                    final message = data['message'];
                    if (code == "200") {
                      // showing messages
                      Fluttertoast.showToast(msg: message);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Activity(),));
                    } else if(code == '400') {
                      final errorMessage=data['message']['email'][0];
                      // Shwing the messages
                      Fluttertoast.showToast(msg: errorMessage);
                    }else if(code == '500'){
                      final errorMessage=data['error'];
                      // Shwing the messages
                      Fluttertoast.showToast(msg: errorMessage);
                    }
                  } catch (e) {
                    print("Exception is : $e");
                  }
                } else {
                  Fluttertoast.showToast(msg: 'Please select your gender.');
                }
              },
              style: ElevatedButton.styleFrom(
                  overlayColor: Colors.lightBlueAccent,
                  backgroundColor: Colors.lightBlueAccent),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionForCamerAndGalley() {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: ShapeBorder.lerp(
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          100),
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(top: 5),
                width: double.infinity,
                child: Card(
                    color: Colors.blue.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextButton(
                            onPressed: () async {
                              imagePickerMethod(ImageSource.camera);
                              await Future.delayed(Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'Camera',
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ),
                        ),
                      ],
                    ))),
            Container(
                width: double.infinity,
                child: Card(
                    color: Colors.blue.shade50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextButton(
                              onPressed: () async {
                                imagePickerMethod(ImageSource.gallery);
                                await Future.delayed(Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                'Gallery',
                                style: TextStyle(color: Colors.lightBlueAccent),
                              )),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
