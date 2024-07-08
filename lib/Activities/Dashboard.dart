import 'package:complaint_monitoring_system/Activities/Pending_Grievance_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Registered_Grievance_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Rejected_Grievance_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Resolved_Grievance_Activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
      padding: EdgeInsets.all(5),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250, mainAxisExtent: 200),
      children: [
        Card(
          elevation: 10,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Registered_Grievance_Activity(),));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Registered_Grievance_Activity(),));
                    },
                    child: Icon(
                      Icons.note_add_outlined,
                      size: 45,
                    ),
                  ),
                  Text(
                    'All Registered Grievance',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Pending_Grievance_Activity(),));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Pending_Grievance_Activity(),));
                    },
                    child: Icon(
                      Icons.pending_actions,
                      size: 45,
                    ),
                  ),
                  Text(
                    'Pending Grievance',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Resolved_Grievance_Activity(),));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Resolved_Grievance_Activity(),));
                    },
                    child: SvgPicture.asset(
                      'assets/svg_logo/file_done_logo.svg',
                      height: 50,
                    ),
                  ),
                  Text(
                    'Grievance Resolved',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Rejected_Grievance_Activity(),));
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Rejected_Grievance_Activity(),));
                    },
                    child: Icon(
                      Icons.cloud_done,
                      size: 45,
                    ),
                  ),
                  Text(
                    'Rejected Grievance',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        )
      ],
    ));
  }
}
