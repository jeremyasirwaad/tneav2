import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue.shade900,
        ),
        body: Column(
          children: [
            Container(
              height: size.height * 0.1 + 33,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                  ),
                  Positioned(
                      left: 20,
                      child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ))),
                  Positioned(
                      top: 30,
                      right: 50,
                      child: Container(
                        child: Text("Jeremy Asirwaad",
                            style: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 24)),
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
