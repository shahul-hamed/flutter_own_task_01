import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:own_task_01/features/battery_level/battery_level.dart';
import 'package:own_task_01/features/home/home_page.dart';
import 'package:own_task_01/features/posts/di/injenction.dart';
import 'package:own_task_01/features/posts/presentation/screens/posts_screen.dart';

import 'features/live_location/live_location_capture.dart';

void main() {
  // setup();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter own task',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}

