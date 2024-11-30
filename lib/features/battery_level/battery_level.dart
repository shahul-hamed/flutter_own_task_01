import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BatteryPage extends StatefulWidget {
  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  static const platform = EventChannel('com.flutterdev.own_task_01/battery');
  int _batteryPercentage = 0;

  @override
  void initState() {
    super.initState();
    _listenToBatteryUpdates();
  }

  void _listenToBatteryUpdates() {
    platform.receiveBroadcastStream().listen(
          (event) {
        setState(() {
          _batteryPercentage = event;
        });
      },
      onError: (error) {
        print("Error receiving battery data: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Percentage'),
      ),
      body: Center(
        child: Text(
          'Battery Percentage: $_batteryPercentage%',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
