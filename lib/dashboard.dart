import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Center(child: Text("Hello")),));
  }
}