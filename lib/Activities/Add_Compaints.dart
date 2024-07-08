import 'package:complaint_monitoring_system/Activities/Complain_Registration_From.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Add_Complaint extends StatefulWidget {
  const Add_Complaint({super.key});

  @override
  State<Add_Complaint> createState() => _Add_ComplaintState();
}

class _Add_ComplaintState extends State<Add_Complaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Card(
        elevation: 10,
        child: InkWell(
          child: Container(
            width: 250,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/svg_logo/add_complaints2.svg',
                    height: 60,
                    width: 60,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Complain_Registration_From(),));
                  },
                ),
                Text(
                  'Click to register grievance',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(12)),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Complain_Registration_From(),));
          },
        ),
      ),
    ));
  }
}
