import 'dart:convert';
import 'package:complaint_monitoring_system/Activities/Login_Activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLink.dart';
import '../UserDetails.dart';

class Profile_Activity extends StatefulWidget {
  const Profile_Activity({super.key});

  @override
  State<Profile_Activity> createState() => Profile_ActivityState();
}

class Profile_ActivityState extends State<Profile_Activity> {
  String userName = '';
  String  gender= '';
  String  state= '';
  String  district= '';
  String  city= '';
  String  pinCode= '';
  String email = '';
  String contact_number = '';
  String password = '';
  int id = -1;
  bool isLogin = true;
  String profileImage='';

  // Image XFile for profile that is selected by user from its gallery or camera
  XFile? selectImageXFile;

  // image File for profile that is converted from image xFile  to File type
  dynamic selectImageFile;

  late final SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }

  void setUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userName = sharedPreferences.getString(UserDetails.NAME) ?? '';
      contact_number = sharedPreferences.getString(UserDetails.CONTACT_NUMBER) ?? '';
      gender = sharedPreferences.getString(UserDetails.GENDER) ?? '';
      state = sharedPreferences.getString(UserDetails.STATE) ?? '';
      district = sharedPreferences.getString(UserDetails.DISTRICT) ?? '';
      city = sharedPreferences.getString(UserDetails.CITY) ?? '';
      pinCode = sharedPreferences.getString(UserDetails.PIN_CODE) ?? '';
      email = sharedPreferences.getString(UserDetails.EMAIL) ?? '';
      password = sharedPreferences.getString(UserDetails.PASSWORD) ?? '';
      id = sharedPreferences.getInt(UserDetails.ID) ?? -1;
      isLogin = sharedPreferences.getBool(UserDetails.ISLOGEDIN) ?? true;
      profileImage = sharedPreferences.getString(UserDetails.PROFILE)??'';
    });
  }

  void imagePickerMethod(ImageSource source) async {
    dynamic pickedImage = await ImagePicker().pickImage(source: source);
    final request = await MultipartRequest('POST',Uri.parse(ApiLink.updateUserProfileApi));
    request.fields["id"]=id.toString();
    request.fields["email"]=email;
    request.files.add(await MultipartFile.fromPath(
        'image', pickedImage!.path));
    var response = await request.send();
    final data = jsonDecode(await response.stream.bytesToString());
    final code = data['code'];
    final message = data['message'];
    print('$data');
    if(code=='200') {
      final userDetails=data['userDetails'][0];
      if(userDetails['image']!='') {
        await sharedPreferences.setString(UserDetails.PROFILE,
            ApiLink.baseLink + 'media/' + userDetails['image']);
      }else{
        await sharedPreferences.setString(UserDetails.PROFILE,
            '');
      }
      setState(() {
        profileImage = sharedPreferences.getString(UserDetails.PROFILE)??'';
        Fluttertoast.showToast(msg: message);
      });

    }else{
      Fluttertoast.showToast(msg: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // design App bar
        appBar: AppBar(
          elevation: 15,
          // set title of the page
          iconTheme: IconThemeData(color: Colors.lightBlueAccent),
          title: Text('Your Profile'),
        ),
        // body section of the page
        body: SingleChildScrollView(
          child: Column(
            children: [
              // this container is for the profile image and show user details
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 150,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Card(
                  color: Colors.lightBlueAccent.shade100,
                  elevation: 10,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // this is the Profile imaga widget
                        Stack(
                            fit: StackFit.loose,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: CircleAvatar(
                                    radius: 52,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: profileImage==''? Icon(Icons.person,size: 60,color: Colors.grey,):Image.network(
                                          profileImage,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: IconButton(onPressed: (){
                                  showDialog(context: context, builder: (context) => optionForCamerAndGalley(),);
                                }, icon: CircleAvatar(radius: 15,backgroundColor:Colors.white,child: Icon(Icons.edit,color: Colors.lightBlueAccent,))),
                              )
                            ]
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(fontSize: 21),
                            ),
                            Text(
                              contact_number,
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 15),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // used for giving space
              SizedBox(
                height: 10,
              ),

              // this section is for Delete Acount
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                height: 300,
                child: Card(
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
                                'Name :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(width: 30,),
                              Text(
                                userName,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Gender :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(width: 17,),
                              Text(
                                gender,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'State :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(width: 30,),
                              Text(
                               state,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'District :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(width: 13,),
                              Text(
                                district,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'City :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              SizedBox(width: 38,),
                              Text(
                                city,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Pin Code :',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                pinCode,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.shade100,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // used for giving space
              SizedBox(
                height: 15,
              ),

              // this section is for Change Password
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                height: 70,
                child: InkWell(
                  child: Card(
                    elevation: 5,
                    color: Colors.lightBlueAccent.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(flex: 5, child: Text("Change Password",style: TextStyle(fontSize: 18),)),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          updatePasswordDialogBox(password,email,id));
                                },
                                icon: Icon(Icons.lock_outline),
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) =>
                            updatePasswordDialogBox(password,email,id));
                  },
                  borderRadius: BorderRadius.circular(12),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // used for giving space
              SizedBox(
                height: 15,
              ),

              // this section is for logout
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                height: 70,
                child: InkWell(
                  child: Card(
                    elevation: 5,
                    color: Colors.lightBlueAccent.shade100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(flex: 5, child: Text("Logout",style: TextStyle(fontSize: 18),)),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: ()  {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          logoutAlertDialogBox());
                                },
                                icon: Icon(Icons.logout_sharp),
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => logoutAlertDialogBox());
                  },
                  borderRadius: BorderRadius.circular(12),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ));
  }

  Widget logoutAlertDialogBox() {
    return Dialog(
      child: Container(
        height: 125,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   child: SvgPicture.asset(
                //     'assets/svg_icons/dhamtari_map_svg.svg',
                //     width: 29,
                //     height: 29,
                //   ),
                //   backgroundColor: Colors.white,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 8),
                  child: Text(
                    'Complaint Monitoring System',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Do you want to logout ?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () async {
                      if (isLogin) {
                        isLogin = false;
                        await sharedPreferences.setBool(
                            UserDetails.ISLOGEDIN, isLogin);
                        await sharedPreferences.setInt(
                            UserDetails.ID, -1);
                        await sharedPreferences.setString(
                            UserDetails.NAME, '');
                        await sharedPreferences.setString(
                            UserDetails.EMAIL, '');
                        await sharedPreferences.setString(
                            UserDetails.PASSWORD, '');
                        await sharedPreferences.setString(UserDetails.PROFILE, '');
                        await sharedPreferences.setBool(
                            UserDetails.ISLOGEDIN, false);
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Login_Activity(),
                          ),(Route<dynamic> route) => false,);
                      }
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deleteAccountAlertDialogBox() {
    return Dialog(
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   child: SvgPicture.asset(
                //     'assets/svg_icons/dhamtari_map_svg.svg',
                //     width: 29,
                //     height: 29,
                //   ),
                //   backgroundColor: Colors.white,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 8),
                  child: Text(
                    'Complaint Monitoring System',
                    style: TextStyle(fontWeight: FontWeight.w500,),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Are you sure want to delete your account ?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () async {
                      try {
                        if (id != -1 && email != "") {
                          final body = jsonEncode({
                            "id": id,
                            "email": email,
                          });
                          final response =
                          await delete(Uri.parse(ApiLink.deleteUserAcApi),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: body);

                          final data = jsonDecode(response.body);
                          if (data != null) {
                            String message = data['message'];
                            final code = data['code'];
                            if (code == "200") {
                              await sharedPreferences.setInt(
                                  UserDetails.ID, -1);
                              await sharedPreferences.setString(
                                  UserDetails.NAME, '');
                              await sharedPreferences.setString(
                                  UserDetails.EMAIL, '');
                              await sharedPreferences.setString(
                                  UserDetails.PASSWORD, '');
                              await sharedPreferences.setString(UserDetails.PROFILE, '');
                              await sharedPreferences.setBool(
                                  UserDetails.ISLOGEDIN, false);
                              Fluttertoast.showToast(msg: message);
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Login_Activity(),
                                ),(Route<dynamic> route) => false,);
                            } else {
                              Fluttertoast.showToast(msg: message);
                            }
                          }
                        }

                      } catch (e) {
                        print('Error message is : $e');
                      }
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )),
              ],
            )
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
                padding: const EdgeInsets.only(top: 4.0,left: 2,right: 2),
                width: double.infinity,
                child: Card(
                    color: Colors.lightBlueAccent.shade100,
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ))),
            Container(
                padding: const EdgeInsets.only(left: 2,right: 2),
                width: double.infinity,
                child: Card(
                    color: Colors.lightBlueAccent.shade100,
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
                                style: TextStyle(color: Colors.white),
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

class updatePasswordDialogBox extends StatefulWidget {
  String oldPassword;
  String email;
  int id;
  updatePasswordDialogBox(this.oldPassword,this.email,this.id,{super.key});

  @override
  State<updatePasswordDialogBox> createState() =>
      _updatePasswordDialogBoxState(oldPassword,email,id);
}

class _updatePasswordDialogBoxState extends State<updatePasswordDialogBox> {
  String oldPassword;
  String email;
  int id;

  _updatePasswordDialogBoxState(this.oldPassword,this.email,this.id);

  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocusNode = FocusNode();
    passwordFocusNode2 = FocusNode();
    print('$oldPassword');
  }

  bool obsureText = true;
  bool obsureText2 = true;

  // used for error name
  String? passworStringError = null;

  // used for error re-enter password
  String? passworStringError2 = null;
  // for email focusNode
  late FocusNode passwordFocusNode;

  // for password focusNode
  late FocusNode passwordFocusNode2;
  // controller of Password TextField
  var passwordController = TextEditingController();

  // controller of re-enter Password TextField
  var passwordController2 = TextEditingController();
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
    } else if(passwordController.text.toString()==oldPassword.toString()){
      passworStringError ='Matched with old password';
    }else {
      setState(() {
        passworStringError = null;
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
    } else if (passwordController2.text.isEmpty) {
      setState(() {
        passworStringError2 = 'Re-enter password field is empty';
      });
    } else {
      setState(() {
        passworStringError2 = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 330,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   child: SvgPicture.asset(
                //     'assets/svg_icons/dhamtari_map_svg.svg',
                //     width: 29,
                //     height: 29,
                //   ),
                //   backgroundColor: Colors.white,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 8),
                  child: Text(
                    'Complaint Monitoring System',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "The new password must be difference from your old password",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: obsureText,
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
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(obsureText){
                        setState(() {
                          obsureText=false;
                        });
                      }else{
                        setState(() {
                          obsureText=true;
                        });
                      }

                    },
                    icon: Icon(Icons.remove_red_eye_outlined,size: 20,),
                  ),
                  suffixIconColor: Colors.lightBlueAccent.shade400,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                obscureText: obsureText2,
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
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(obsureText2){
                        setState(() {
                          obsureText2=false;
                        });
                      }else{
                        setState(() {
                          obsureText2=true;
                        });
                      }
                    },
                    icon: Icon(Icons.remove_red_eye_outlined,size: 20,),
                  ),
                  suffixIconColor: Colors.lightBlueAccent.shade400,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                cursorColor: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent.shade400),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: () async{
                    try {
                      final response = await post(
                          Uri.parse(ApiLink.updateUserPasswordApi),
                          headers: {
                            'content-type': 'application/json'
                          },
                          body: jsonEncode({
                            "id": id,
                            "email": email,
                            "password": passwordController.text.trim()
                          }));

                      final data =jsonDecode(response.body);
                      print('$data');
                      String message = data['message'];
                      String code = data['code'];
                      if(code=='200'){
                        Fluttertoast.showToast(msg: message);
                        Navigator.of(context).pop();
                      }else{
                        Fluttertoast.showToast(msg: message);
                      }

                    } catch (e) {
                      print('Errom message is : $e');
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent.shade400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
