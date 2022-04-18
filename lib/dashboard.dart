import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './model//listinfo.dart';
import 'package:page_transition/page_transition.dart';
import './login.dart';
import './model/Statusinfo.dart';

class dashboard extends StatefulWidget {
  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.blue.shade900,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      alignment: Alignment.bottomCenter,
                      child: loginpage()));
            },
            icon: Icon(Icons.logout))
      ],
    );

    Size size = MediaQuery.of(context).size;
    double hightofdev = size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    int _selectedpage = 0;

    final _pageoptions = [
      Detailspage(hightofdev: hightofdev),
      Statuspage(hightofdev: hightofdev)
    ];
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Container(
            height: hightofdev * 0.15,
            child: Stack(
              children: [
                Container(
                  height: hightofdev * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Positioned(
                    left: 40,
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.black,
                            image: DecorationImage(
                                image: AssetImage("asserts/bankimg.jpeg"),
                                fit: BoxFit.cover)))),
                Positioned(
                    top: 30,
                    right: 40,
                    child: Container(
                      child: Text("Jeremy Asirwaad",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 20)),
                    ))
              ],
            ),
          ),
          // Detailspage(hightofdev: hightofdev)
          _pageoptions[_currentIndex]
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          backgroundColor: Colors.blue.shade900,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.badge), label: "Details"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article), label: "Application Status")
          ],
        ),
      ),
    );
  }
}

class Detailspage extends StatelessWidget {
  const Detailspage({
    Key? key,
    required this.hightofdev,
  }) : super(key: key);

  final double hightofdev;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: hightofdev * 0.75 - 30,
        // decoration: BoxDecoration(color: Colors.black),
        child: ListView(children: [
          Text(
            "Student Details",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          listinfo("Application No", 189654230, false),
          listinfo("12th Register Number", 2018118, false),
          listinfo("12th Roll number", 741258, false),
          listinfo("Aadhaar number", "1234/12345/12345", false),
          listinfo("Community", "Chowdry", false),
          listinfo("Nativity", "Indian", false),
          listinfo("Group code", "092", false),
          Text(
            "Academic Details",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          listinfo("Sub 1 mark", "95", false),
          listinfo("Sub 2 mark", "95", false),
          listinfo("Sub 3 mark", "95", false),
          listinfo("Cutoff", "189.5", false),
          listinfo("Rank", "Not Yet Published", true),
          Text(
            "Special Reservation",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          listinfo("Physically challenged", "No", false),
          listinfo("Ex-servicemen", "No", false),
          listinfo("Sports", "No", false),
          listinfo("Studied in Government School", "No", false),
        ]),
      ),
    );
  }
}

class Statuspage extends StatelessWidget {
  const Statuspage({
    Key? key,
    required this.hightofdev,
  }) : super(key: key);

  final double hightofdev;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: hightofdev * 0.75 - 30,
        // decoration: BoxDecoration(color: Colors.black),
        child: ListView(children: [
          Text(
            "Application Status",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          Statusinfo("Registration", "Completed", true),
          Statusinfo("Certificate Verification", "Rejected", false),
          Statusinfo("Tentative allotment", "Alloted", true),
          Statusinfo("Tentative allotment confirmation status",
              "Not Yet Confirmed", false),
          Statusinfo("Tentative allotment confirmation chosen",
              "Government College of Technology", true),
          Statusinfo("Provisional allotment generated", "No", false),
          Statusinfo("Joined college", "No", false),
        ]),
      ),
    );
  }
}
