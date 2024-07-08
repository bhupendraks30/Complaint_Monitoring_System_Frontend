import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs_Activity extends StatefulWidget {
  const AboutUs_Activity({super.key});

  @override
  State<AboutUs_Activity> createState() => _AboutUs_ActivityState();
}

class _AboutUs_ActivityState extends State<AboutUs_Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlueAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 10,),
            buildSectionContent('Welcome to the Complaint Monitoring System for Kanker District!'),
            SizedBox(height: 6,),
            buildSectionContent('Our mission is to establish a transparent and accountable system that facilitates the efficient handling of complaints from citizens. We aim to bridge the gap between the public and government agencies by providing a platform for citizens to voice their concerns and track the progress of their complaints.'),
            SizedBox(height: 6,),
            buildSectionContent('We provide a user-friendly platform for citizens to register complaints, submit feedback, and monitor the resolution process. Our system ensures that complaints are promptly attended to and resolved by the relevant authorities. By promoting transparency and accountability, we strive to enhance public trust in governance and improve service delivery.'),
            SizedBox(height: 6,),
            buildSectionContent('Our team consists of dedicated individuals committed to facilitating positive change in Kanker District. From developers to support staff, each member plays a crucial role in maintaining the integrity and functionality of our system.'),
            SizedBox(height: 6,),
            buildSectionContent("We encourage citizens to join us in our mission to create a more responsive and accountable governance system. Whether you're reporting an issue, providing feedback, or spreading awareness about our platform, your participation is essential in driving meaningful change.")

          ],
        ),
      ),
    );
  }


  Widget buildSectionContent(String title) {
    List<TextAlign> align = [TextAlign.center, TextAlign.right];
    return Container(
      padding: EdgeInsets.only(left: 8, top: 5, right: 8),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildListItems(String title, String description) {
    List<TextAlign> align = [TextAlign.center, TextAlign.right];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8, top: 5, right: 8),
          alignment: Alignment.topLeft,
          child: Text(
            title,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8, bottom: 5, right: 8),
          alignment: Alignment.topLeft,
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

}
