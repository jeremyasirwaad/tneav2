import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './dashboard.dart';
import 'package:page_transition/page_transition.dart';

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade400,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   'asserts/logo.webp',
                  //   height: 80,
                  //   width: 80,
                  // ),
                  Text(
                    "LOGIN",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Official TNEA Mobile App",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        // height: 100,
                        // width: double.infinity,
                        // color: Colors.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.blue.shade200,
                                blurRadius: 15.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Column(children: [
                          // Container(
                          //   decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200)))),
                          // )

                          Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade100))),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, left: 20, right: 20, bottom: 8),
                                    child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500))),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, left: 20, right: 20, bottom: 8),
                                  child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade500))),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Login Using OTP",
                        style: GoogleFonts.roboto(color: Colors.grey.shade600),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: dashboard()))
                        },
                        child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Colors.blue.shade900,
                                      Colors.blue.shade800,
                                      // Colors.blue.shade400,
                                    ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text("Login",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.white,
                                  )),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
