import 'package:complaint_monitoring_system/Activities/Main_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Profile_Activity.dart';
import 'package:flutter/material.dart';

import 'Activities/Login_Activity.dart';
import 'Activities/Registration_Form.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login_Activity(),
    routes: {
      '/registration_activity': (context)=>Registration_Form(),
      '/login_activity': (context)=>Login_Activity(),
      '/main_activity': (context)=>Main_Activity(),
      '/profile_activity': (context)=> Profile_Activity(),
    }
  ));
}


