import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Feedback_Form_Activity extends StatefulWidget {
  const Feedback_Form_Activity({super.key});

  @override
  State<Feedback_Form_Activity> createState() => _Feedback_Form_ActivityState();
}

class _Feedback_Form_ActivityState extends State<Feedback_Form_Activity> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
  }

  // controller of NameTextField
  var nameController = TextEditingController();
  // Controller of Email TextField
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();
  // for email focusNode
  late FocusNode emailFocusNode;
  late FocusNode mobileFocusNode;
  late FocusNode addressFocusNode;
  late FocusNode nameFocusNode;
  // used for error message
  String? emailStringError = null;
  String? mobileStringError = null;
  String? addressStringError = null;
// used for error name
  String? nameStringError = null;
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

  // used to perform validation
  void checkValidationForName() {
    if (nameController.text.isEmpty) {
      setState(() {
        nameStringError = 'Name field is empty';
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
      });
    } else {
      setState(() {
        addressStringError = null;
        addressFocusNode.unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feedback Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: Card(
                elevation: 5,
                child: ClipRRect(
                  child: SvgPicture.asset('assets/svg_logo/nic_logo.svg'),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Type your feedback here',style: TextStyle(fontSize: 17),),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
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
                      EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    checkValidationForName();
                    checkValidationForEmail();
                    checkValidationForMobile();
                    checkValidationForAddress();
                  },
                  style: ElevatedButton.styleFrom(
                      overlayColor: Colors.lightBlueAccent,
                      backgroundColor: Colors.lightBlueAccent),
                  child: Text(
                    'Submit',
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
