import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines/timelines.dart';
import './model//listinfo.dart';
import 'package:page_transition/page_transition.dart';
import './login.dart';
import './model/Statusinfo.dart';
import './datamodel/userdata.dart';
import 'package:timelines/timelines.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

class dashboard extends StatefulWidget {
  final Userdata data;
  dashboard(this.data);
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
      Detailspage(hightofdev: hightofdev, data: widget.data),
      Statuspage(hightofdev: hightofdev),
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
                                image: NetworkImage(widget.data.img),
                                fit: BoxFit.cover)))),
                Positioned(
                    top: 30,
                    right: 40,
                    child: Container(
                      child: Text(widget.data.name,
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
                icon: Icon(Icons.article), label: "Application Status"),
          ],
        ),
      ),
    );
  }
}

class Detailspage extends StatelessWidget {
  const Detailspage({Key? key, required this.hightofdev, required this.data})
      : super(key: key);

  final double hightofdev;
  final Userdata data;

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
          listinfo("Application No", data.appno, false),
          listinfo("12th Register Number", data.s12regno, false),
          listinfo("12th Roll number", data.s12rollno, false),
          listinfo("Aadhaar number", data.adharno, false),
          listinfo("Community", data.comunity, false),
          listinfo("Nativity", data.Nativity, false),
          listinfo("Group code", data.Groupcode, false),
          Text(
            "Academic Details",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          listinfo("Sub 1 mark", data.s1, false),
          listinfo("Sub 2 mark", data.s2, false),
          listinfo("Sub 3 mark", data.s3, false),
          listinfo("Cutoff", data.coff, false),
          listinfo("Rank", data.rank, true),
          Text(
            "Special Reservation",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(
            height: 35,
          ),
          listinfo(
              "Physically challenged", data.pchalage ? "Yes" : "No", false),
          listinfo("Ex-servicemen", data.exser ? "Yes" : "No", false),
          listinfo("Sports", data.sport ? "Yes" : "No", false),
          listinfo("Studied in Government School", data.studgovt ? "Yes" : "No",
              false),
        ]),
      ),
    );
  }
}

class Statuspage extends StatefulWidget {
  const Statuspage({
    Key? key,
    required this.hightofdev,
  }) : super(key: key);

  final double hightofdev;

  @override
  State<Statuspage> createState() => _StatuspageState();
}

class _StatuspageState extends State<Statuspage> {
  List<bool> isopen = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
          width: double.infinity,
          height: widget.hightofdev * 0.75 - 30,
          // decoration: BoxDecoration(color: Colors.black),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Application Status",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          isopen[index] = !isopen[index];
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              height: 0,
                              child: ListTile(
                                trailing: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 27,
                                ),
                                title: Text('Registration'),
                              ),
                            );
                          },
                          body: Container(
                            // height: 0,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Payment Status :"),
                                    Text(
                                      " Completed",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ]),
                                  Row(children: [
                                    Text("Certificate Upload :"),
                                    Text(
                                      " Completed",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ]),
                                ],
                              ),
                              subtitle: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text("24/7/2022 - 22/8/2022")),
                            ),
                          ),
                          isExpanded: isopen[0],
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              height: 0,
                              child: ListTile(
                                trailing: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  'Certificate Verification',
                                ),
                              ),
                            );
                          },
                          body: Container(
                            // height: 60,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Verification :"),
                                    Text(
                                      " Failed",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                                ],
                              ),
                              subtitle: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                      "DOB doesnt match with BirthCertificate")),
                            ),
                          ),
                          isExpanded: isopen[1],
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              height: 0,
                              child: ListTile(
                                trailing: Icon(
                                  Icons.hourglass_bottom,
                                  color: Colors.orange,
                                  size: 27,
                                ),
                                title: Text('Choice Filling'),
                              ),
                            );
                          },
                          body: Container(
                            height: 60,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Choices Freezed :"),
                                    Text(
                                      " Pending",
                                      style: TextStyle(color: Colors.orange),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: isopen[2],
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              height: 0,
                              child: ListTile(
                                // trailing: Icon(
                                //   Icons.check,
                                //   color: Colors.green,
                                //   size: 27,
                                // ),
                                title: Text('Tentative Allotment'),
                              ),
                            );
                          },
                          body: Container(
                            height: 60,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Alloted College :"),
                                    Text(
                                      " Pending",
                                      style: TextStyle(color: Colors.orange),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: isopen[3],
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                              height: 0,
                              child: ListTile(
                                // trailing: Icon(
                                //   Icons.check,
                                //   color: Colors.green,
                                //   size: 27,
                                // ),
                                title: Text('Provisional Allotment'),
                              ),
                            );
                          },
                          body: Container(
                            height: 60,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Text("Allotment :"),
                                    Text(
                                      " Pending",
                                      style: TextStyle(color: Colors.orange),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          isExpanded: isopen[4],
                        ),
                      ],
                    ),
                  ]),
            ),
          )),
    );
  }
}
