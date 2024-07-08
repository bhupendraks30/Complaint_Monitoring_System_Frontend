import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Complaints_Details_Activity extends StatefulWidget {
  var complainDetails;
  Complaints_Details_Activity(this.complainDetails, {super.key});

  @override
  State<Complaints_Details_Activity> createState() =>
      _Compaints_Details_ActivityState(complainDetails);

}

class _Compaints_Details_ActivityState
    extends State<Complaints_Details_Activity> {
  var dataList;

  _Compaints_Details_ActivityState(this.dataList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints Status'),
        elevation: 15,
        backgroundColor:Colors.blue.shade300,
      ),
      body: Center(
        child: Card(
          child: Container(
            width: double.infinity,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text('Complaint Details',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)],),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Grievance Id :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['cid'],
                        // '652255484',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Grievance Category :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['category'],
                        // '652255484',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Grievance Description :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['description'],
                        // '652255484',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Grievance Register Date :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['date_submitted'].toString().substring(0, 10),
                        // '652255484',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Grievance Status :',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        dataList['status'],
                        // '652255484',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50,),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
