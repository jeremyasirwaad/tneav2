import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tneav3/PushNotification.dart';

import './datamodel/userdata.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './dashboard.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:app_settings/app_settings.dart';

class loginpage extends StatefulWidget {
  bool loading = false;

  @override
  State<loginpage> createState() => _loginpageState();
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _loginpageState extends State<loginpage> {
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void initState() {

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );

      checkForInitialMessage();
      registerNotification();

      setState(() {
        _notificationInfo = notification;
      });
    });
    super.initState();
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body']
        );

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 10),
          );
        }

        setState(() {
          _notificationInfo = notification;
        });
        print('Accepted');
      });
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  final _formKey = GlobalKey<FormState>();
  bool hasinternet = true;
  bool hidepass = true;
  String? email;
  String? password;
  var errorsg = "";
  late Userdata user;
  Future save() async {
    hasinternet = await InternetConnectionChecker().hasConnection;
    if (!hasinternet) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert"),
            content:
            const Text("check your internet connection and try again"),
            actions: [
              TextButton(
                  onPressed: () => AppSettings.openDeviceSettings(),
                  child: const Text("Turn On")),
            ],
          ),
          barrierDismissible: true);
      return 0;
    }
    setState(() {
      widget.loading = true;
    });
    var res = await http.post(Uri.parse("https://mytnea.herokuapp.com/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, dynamic>{
          "email": email,
          "password": password
        });

    // print(res.body);
    // final parsedJson = jsonDecode(res.body);
    // final data = Userdata.fromJson(jsonDecode(res.body));
    // print(data.name);
    // print(parsedJson);
    // final user = User

    var data = jsonDecode(res.body);
    if (!data['status']) {
      setState(() {
        widget.loading = false;
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Alert"),
            content: Text("Invalid Username or Password"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"))
            ],
          ),
          barrierDismissible: true);
    }

    if (data['status']) {
      //  user = Userdata.fromJson(data);
      // final parsedjson = jsonDecode(data);
      final usermodeldata = Userdata.fromJson(data['data']);
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter,
              child: dashboard(usermodeldata)));
    }
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        actions: [
          widget.loading
              ? Container(
            margin: EdgeInsets.only(right: 13),
            child: SpinKitCircle(
              color: Colors.white,
              size: 37.0,
            ),
          )
              : Container()
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        color: Colors.blue.shade900,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        //   Colors.blue.shade900,
        //   Colors.blue.shade800,
        //   Colors.blue.shade400,
        // ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Row(children: [
                Column(
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
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                  child: Image.asset(
                    "asserts/logo.webp",
                    height: 80,
                    width: 80,
                  ),
                )
              ]),
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

                          Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade100))),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          left: 20,
                                          right: 20,
                                          bottom: 8),
                                      child: TextFormField(
                                          controller: TextEditingController(
                                              text: email),
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          validator: (String? value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return "Enter Email";
                                            } else if (RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value as String)) {
                                              return null;
                                            } else {
                                              return "Enter Valid Email";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color:
                                                  Colors.grey.shade500))),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, left: 20, right: 20, bottom: 8),
                                    child: TextFormField(
                                        controller: TextEditingController(
                                            text: password),
                                        onChanged: (value) {
                                          password = value;
                                        },
                                        validator: (String? value) {
                                          if (value != null && value.isEmpty) {
                                            return "Enter Password";
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: hidepass,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    hidepass = !hidepass;
                                                  });
                                                },
                                                icon: Icon(hidepass
                                                    ? Icons.visibility_off
                                                    : Icons.visibility)),
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500))),
                                  ),
                                ],
                              ),
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
                          if (_formKey.currentState!.validate())
                            {
                              save(),
                            }
                          else
                            {print("not ok")}
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
