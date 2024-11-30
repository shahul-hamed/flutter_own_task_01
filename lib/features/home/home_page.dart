import 'package:flutter/material.dart';
import 'package:own_task_01/features/battery_level/battery_level.dart';
import 'package:own_task_01/features/live_location/live_location_capture.dart';
import 'package:own_task_01/features/posts/presentation/screens/posts_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List activities = ["Clean architecture with JSON place holder API Integration",
    "Communicate Platform native to Dart side to capture battery level using Event Channel",
    "Real time local capturing using Geolocator"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Activities"),
      ),
      body: ListView.separated(
        separatorBuilder: (c,i)=>Divider(height: 8,color: Colors.grey.shade300,thickness: 2.5,),
        shrinkWrap: true,padding: EdgeInsets.symmetric(vertical: 15,horizontal: 18),
        itemBuilder: (c,i) {
          return  InkWell(
            onTap: ()=>navigateActivities(i),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0,top: 5),
              child: Text("${i+1}. ${activities[i]}",style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.w500
              ),),
            ),
          );
        },
        itemCount: activities.length,
      ),
    );
  }

  navigateActivities(int i) {
    switch(i) {
      case 0 :
      return Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
      case 1:
      return Navigator.push(context, MaterialPageRoute(builder: (context)=>BatteryPage()));
      case 2:
       return Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveLocationCapture()));
    }
  }
}
