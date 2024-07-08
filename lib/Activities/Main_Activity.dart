import 'package:complaint_monitoring_system/Activities/AboutUs_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Add_Compaints.dart';
import 'package:complaint_monitoring_system/Activities/Complaint_Status.dart';
import 'package:complaint_monitoring_system/Activities/Contact_Us_Activity.dart';
import 'package:complaint_monitoring_system/Activities/Dashboard.dart';
import 'package:complaint_monitoring_system/Activities/Feedback_Form_Activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserDetails.dart';

class Main_Activity extends StatefulWidget {
  const Main_Activity({super.key});

  @override
  State<Main_Activity> createState() => _Main_ActivityState();
}

class _Main_ActivityState extends State<Main_Activity> {
  var list_of_Widgets = [
    Dashboard(),
    Add_Complaint(),
    Complaint_Status(),
  ];
  var list_of_Titles = [
    'Dashboard',
    'Add Grievance',
    'Grievance Status',
  ];
  var selectedIndex = 0;
  String profileImage = '';
  String title = 'Dashboard';

  void getUserDataFromSharedPre() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      profileImage = sharedPref.getString(UserDetails.PROFILE) ?? '';
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDataFromSharedPre();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  "CMS " + title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                )),
            Expanded(
                flex: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile_activity');
                  },
                  icon: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: profileImage == ''
                            ? Icon(
                                Icons.person,
                                size: 35,
                              )
                            : Image.network(
                                profileImage,
                                fit: BoxFit.cover,
                                width: 42,
                                height: 42,
                              )),
                  ),
                ))
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue.shade50,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DrawerHeader(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            "assets/svg_logo/emblem_of_India.svg",
                            width: 80,
                            height: 80,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                "assets/svg_logo/nic_logo.svg",
                                width: 50,
                                height: 60,
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            ListTile(
              title: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.contact_page,
                        size: 21,
                        color: Colors.blue,
                      ),
                      // SvgPicture.asset(
                      //   "assets/svg_logo/share_svg.svg",
                      //   width: 17,
                      //   height: 17,
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Contact Us"),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Contact_Us_Activity()));
                  }),
            ),

            ListTile(
                title: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.feedback,
                          size: 21,
                          color: Colors.blue,
                        ),
                        // SvgPicture.asset(
                        //   "assets/svg_logo/about_us_svg.svg",
                        //   width: 17,
                        //   height: 17,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("About Us"),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUs_Activity()));
                    })),

            // GestureDetector(
            //   child: ListTile(
            //     title: Row(
            //       children: [
            //         SvgPicture.asset("assets/svg_icons/gallery_svg.svg",width: 15,height: 15,),
            //         SizedBox(width: 5,),
            //         Text("My Gallery"),
            //       ],
            //     ),
            //   ),
            // ),

            ListTile(
              title: GestureDetector(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg_logo/feedback_icon.svg",
                        width: 17,
                        height: 17,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Feedback"),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Feedback_Form_Activity()));
                  }),
            ),

            ListTile(
              title: GestureDetector(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg_logo/share_icon.svg",
                      width: 17,
                      height: 17,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Share"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: list_of_Widgets[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(
              tooltip: 'Add Complaints',
              activeIcon: SvgPicture.asset(
                'assets/svg_logo/comlaint_reg2.svg',
                width: 22,
                height: 22,
              ),
              icon: SvgPicture.asset(
                'assets/svg_logo/comlaint_reg.svg',
                width: 22,
                height: 22,
              ),
              label: "Add Complaint"),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/svg_logo/status_2.svg',
                width: 25,
                height: 25,
              ),
              icon: SvgPicture.asset(
                'assets/svg_logo/status.svg',
                width: 25,
                height: 25,
              ),
              label: "Complaint Status"),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            title = list_of_Titles[index];
          });
        },
        selectedItemColor: Colors.lightBlueAccent,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    );
  }
}
