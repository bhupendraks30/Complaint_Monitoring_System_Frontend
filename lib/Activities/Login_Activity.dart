import 'dart:convert';

import 'package:complaint_monitoring_system/Activities/Main_Activity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiLink.dart';
import '../UserDetails.dart';

class Login_Activity extends StatefulWidget {
  const Login_Activity({super.key});

  @override
  State<Login_Activity> createState() => _Login_ActivityState();
}

class _Login_ActivityState extends State<Login_Activity> {

  // creatign sharedpreference object
  late SharedPreferences sharedPreference;

  // used for error message
  String? emailStringError = null;

  // used for error message
  String? passworStringError = null;

  // for email focusNode
  late FocusNode emailFocusNode;

  // for password focusNode
  late FocusNode passwordFocusNode;

  // Controller of Email TextField
  var emailController = TextEditingController();
  // controller of Password TextField
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    checkUserLogin();
  }

  // used to perform validation
  void checkValidationForEmail() {
    // for Email TextField
    bool isValidEmail = EmailValidator.validate(emailController.text.trim());
    if (!isValidEmail && !emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Please enter a valid email';
        emailFocusNode.requestFocus();
      });
    } else if (emailController.text.isEmpty) {
      setState(() {
        emailStringError = 'Email field is empty';
      });
    } else {
      setState(() {
        emailStringError = null;
        emailFocusNode.unfocus();
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
    } else if (passwordController.text.isEmpty) {
      setState(() {
        passworStringError = 'Password field is empty';
      });
    } else {
      setState(() {
        passworStringError = null;
      });
    }
  }

  // this is for shared preference
  void checkUserLogin() async {
    sharedPreference = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreference.getBool(UserDetails.ISLOGEDIN);
    if (isLogin != null) {
      if (isLogin) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Main_Activity(),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 15,
          backgroundColor: Colors.lightBlueAccent,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Login Page",style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 320,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.blue.shade50,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Complaint Monitoring System',style: TextStyle(fontSize: 18),),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),

                            // this is the TextField for Enter your Email
                            child: TextField(
                              // set the controller
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              // set the focusNode variable for email textField
                              focusNode: emailFocusNode,

                              onTapOutside: (event) {
                                checkValidationForEmail();
                              },

                              // here for starting the decoration
                              decoration: InputDecoration(
                                // set label
                                label: Text(
                                  "Enter you email",
                                  style: TextStyle(color: Colors.black),
                                ),

                                errorText: emailStringError,

                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),

                                // set the error border show when setting the validation
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),

                                // set decoration when the TextField is enabled
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),

                                // set decoration when the TextField is Focused
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

                          // used for Maintain the distance
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),

                            // this is the TextField for Enter your Password
                            child: TextField(
                              // used for encrypt the password
                              obscureText: true,

                              controller: passwordController,

                              // set password focusNode
                              focusNode: passwordFocusNode,

                              onTapOutside: (event) {
                                checkValidationForPassword();
                              },
                              // use to decorate the TextField
                              decoration: InputDecoration(
                                // used to set the label on the textField
                                label: Text(
                                  "Enter you password",
                                  style: TextStyle(color: Colors.black),
                                ),

                                // used to decorate the TextField for show the Error
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),

                                errorText: passworStringError,
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
                          SizedBox(
                            height: 20,
                          ),

                          // this the Login button
                          ElevatedButton(
                            // On click method
                            onPressed: () async {
                              try {
                                // checking validations
                                checkValidationForEmail();
                                checkValidationForPassword();
                                if (emailController.text != "" && passwordController.text != "") {
                                  // creating url
                                  final uriLink = Uri.parse(ApiLink.userLoginApi);
                                  // creating header for post
                                  final headers = {
                                    'Content-Type': 'application/json',
                                  };
                                  // creating body for post in which we se the email and password
                                  final body = jsonEncode({
                                    "email": emailController.text.toString(),
                                    "password": passwordController.text.toString(),
                                  });
                                  // getting response from the api
                                  var response =
                                  await post(uriLink, headers: headers, body: body);

                                  // converting the response into map means decoding the response
                                  Map<dynamic, dynamic> data = jsonDecode(response.body);
                                  // extracting converted response data into the variables
                                  final statusMessage = data['message'];
                                  final statusCode = data['code'];

                                  // checking status code
                                  if (statusCode == "200") {
                                    // extracting User date id, name, etc
                                    // final userDeatails = data['User detials'][0];

                                    await sharedPreference.setInt(
                                        UserDetails.ID, data['user_details'][0]['id']);
                                    await sharedPreference.setString(
                                        UserDetails.UI_ID, data['user_details'][0]['uid']);
                                    await sharedPreference.setString(
                                        UserDetails.NAME, data['user_details'][0]['full_name']);
                                    await sharedPreference.setString(
                                        UserDetails.CITY, data['user_details'][0]['city']);
                                    await sharedPreference.setString(
                                        UserDetails.EMAIL, data['user_details'][0]['email']);
                                    await sharedPreference.setString(
                                        UserDetails.CONTACT_NUMBER, data['user_details'][0]['mobile_number']);
                                    await sharedPreference.setString(
                                        UserDetails.GENDER, data['user_details'][0]['gender']);
                                    await sharedPreference.setString(
                                        UserDetails.STATE, data['user_details'][0]['state']);
                                    await sharedPreference.setString(
                                        UserDetails.DISTRICT, data['user_details'][0]['district']);
                                    await sharedPreference.setString(
                                        UserDetails.ADDRESS, data['user_details'][0]['address']);
                                    await sharedPreference.setString(
                                        UserDetails.PIN_CODE, data['user_details'][0]['pin_code']);
                                    await sharedPreference.setString(
                                        UserDetails.PASSWORD, data['user_details'][0]['password']);
                                    await sharedPreference.setInt(
                                        UserDetails.ROLE, data['user_details'][0]['role']);
                                    await sharedPreference.setBool(UserDetails.ISLOGEDIN, true);
                                    if(data['user_details'][0]['image']!='') {
                                      await sharedPreference.setString(UserDetails.PROFILE,
                                          ApiLink.baseLink + 'media/' + data['user_details'][0]['image']);
                                    }else{
                                      await sharedPreference.setString(UserDetails.PROFILE,
                                          '');
                                    }
                                    Fluttertoast.showToast(msg: statusMessage);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Main_Activity(),
                                        ));
                                  } else if (statusCode == "400") {
                                    // showing toast message
                                    Fluttertoast.showToast(msg: statusMessage);
                                  } else {
                                    Fluttertoast.showToast(
                                      // showing toast messages
                                        msg: statusMessage + " please register fist");
                                  }
                                }
                              } catch (e) {
                                // handling errors
                                print('Error Message is : $e');
                              }
                                    // Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => Main_Activity(),
                                    //     ));


                            },

                            // set the Text
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // used for show the Signup instruction
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Row(
                              children: [
                                Text("You don't have account ?"),
                                InkWell(
                                  child: Text(
                                    " Sign Up",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: (){
                                    Navigator.pushNamed(context, '/registration_activity');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

