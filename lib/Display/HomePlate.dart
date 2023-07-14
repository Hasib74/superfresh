import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supper_fresh_stores/Chart/Chart.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/Category/AllProducts.dart';
import 'package:supper_fresh_stores/Display/Favourite/Favourite.dart';
import 'package:supper_fresh_stores/Display/Home/Home.dart';
import 'package:supper_fresh_stores/Display/Profile/Profile.dart';

import '../Drawer/NaviationDrawer.dart';

class HomePlate extends StatefulWidget {
  final current_state;

  HomePlate({this.current_state});

  @override
  _HomePlateState createState() => _HomePlateState();
}

class _HomePlateState extends State<HomePlate>
    with AutomaticKeepAliveClientMixin {
  var current_selected_page = "home";

  Widget? current_page;

  int variable = 0;

  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  FirebaseMessaging firebaseMessaging =  FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    registerNotification();
    configLocalNotification();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettings = new InitializationSettings(
      android:  initializationSettingsAndroid,);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void registerNotification() {
    firebaseMessaging.requestPermission();

    // firebaseMessaging!.configure(onMessage: (Map<String, dynamic> message) {
    //   print('onMessage: $message');
    //
    //   // if()
    //
    //
    //
    //   return;
    // }, onResume: (Map<String, dynamic> message) {
    //   print('onResume: $message');
    //   return;
    // }, onLaunch: (Map<String, dynamic> message) {
    //   print('onLaunch: $message');
    //   return;
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');

      showNotification(message.data);
    });
    firebaseMessaging.getToken().then((token) {
      print('token: $token');

      FirebaseDatabase.instance
          .reference()
          .child("Token")
          .child(Common.gmail?.replaceAll(".", "") ??"")
          .set({"token": token}).then((_) {
        print("Token Update");
      }).catchError((err) => print(err));
    }).catchError((err) {
      print(err);
    });
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.dfa.flutterchatdemo'
          : 'com.duytq.flutterchatdemo',
      'Flutter chat demo',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
   // var iOSPlatformChannelSpecifics = ;
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, );
    await flutterLocalNotificationsPlugin.show(
        new Random().nextInt(1000),
        message['title'].toString(),
        message['body'].toString(),
        platformChannelSpecifics,
        payload: json.encode(message));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/HomePlate': (BuildContext context) => new HomePlate(),
        '/Profile': (BuildContext context) => new Profile(),
      },
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          if (current_selected_page != "home") {
            setState(() {
              current_selected_page = "home";
            });
          } else {
            exit(0);
          }
          return false ;
        },
        child: Scaffold(
            backgroundColor: Color(0xffF6F6F6),
            key: _globalKey,
            drawer: AppNavigationDrawer(HomePlate().key!, close_drawer, fun_fav,
                fun_home, fun_profile, fun_chart, fun_allproduct),
            appBar: new AppBar(
              title: Text(
                "Super fresh",
                style: TextStyle(
                    color: Color(0xffFF5126), fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Color(0xffF6F6F6),
              leading: InkWell(
                onTap: () {
                  _globalKey.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: Color(0xff747474),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.notifications,
                    color: Color(0xff4A544F),
                  ),
                )
              ],
            ),
            floatingActionButton: Container(
              width: 60,
              height: 60,
              child: FloatingActionButton(
                heroTag: "a",
                hoverElevation: 4,
                backgroundColor: Color(0xffFF5126),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Common.gmail == null
                          ? Container()
                          : StreamBuilder(
                              stream: FirebaseDatabase.instance
                                  .reference()
                                  .child(Common.user)
                                  .child(
                                      Common.gmail?.replaceAll(".", "") ?? "")
                                  .child(Common.basic_info)
                                  .child("login")
                                  .onValue,
                              builder: (context, snap) {
                                if (snap.data == null) {
                                  return Container();
                                } else {
                                  //    return Container();

                                  return StreamBuilder(
                                      stream: FirebaseDatabase.instance
                                          .ref()
                                          .child(Common.chart)
                                          .child(Common.gmail
                                                  ?.replaceAll(".", "") ??
                                              "")
                                          .onValue,
                                      builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
                                        if (snapshot.data == null ||
                                            snapshot.data ==
                                                null) {
                                          return Container();
                                        } else {

                                          List? count = snapshot.data?.snapshot.value as List;
                                          return Positioned(
                                              top: count.length >=
                                                      10
                                                  ? 10
                                                  : 13,
                                              right: count.length >=
                                                      10
                                                  ? 10
                                                  : 13,
                                              child: Text(
                                                "${count.length >= 10 ? "10+" : count.length}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 7,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ));
                                        }
                                      });
                                }
                              },
                            )
                    ],
                  ),
                ),
                onPressed: () {
                  print("Clicked to Chart button");

                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Charts()));
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                width: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //0xff737373

                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              current_selected_page = "home";

                              print(
                                  "Gmail.......................................  ${Common.gmail}");
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.home,
                              color: current_selected_page == "home"
                                  ? Color(0xffFF5126)
                                  : Color(0xff707070),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              variable = 0;
                              current_selected_page = "AllProducts";
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.playlist_add,
                              color: current_selected_page == "AllProducts"
                                  ? Color(0xffFF5126)
                                  : Color(0xff707070),
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              current_selected_page = "fav";
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.favorite,
                              color: current_selected_page == "fav"
                                  ? Color(0xffFF5126)
                                  : Color(0xff707070),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              current_selected_page = "profile";
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Icon(
                              Icons.perm_identity,
                              color: current_selected_page == "profile"
                                  ? Color(0xffFF5126)
                                  : Color(0xff707070),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              child: page(),
            )),
      ),
    );
  }

  close_drawer() {
    _globalKey.currentState?.openEndDrawer();
  }

  fun_fav() {
    setState(() {
      current_selected_page = "fav";
    });
  }

  fun_profile() {
    setState(() {
      current_selected_page = "profile";
    });
  }

  fun_home() {
    setState(() {
      current_selected_page = "home";
    });
  }

  fun_allproduct() {
    setState(() {
      current_selected_page = "AllProducts";
    });
  }

  fun_chart() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => Charts()));
  }

  page() {
    if (current_selected_page == "home") {
      current_page = Home(
        chnage_to_list: chnage_to_list,
        key: HomePlate().key,
      );
    } else if (current_selected_page == "AllProducts") {
      current_page = AllProducts(
        index: variable,
      );
    } else if (current_selected_page == "profile") {
      current_page = Profile();
    } else if (current_selected_page == "fav") {
      current_page = Favourite();
    }

    return current_page;
  }

  chnage_to_list(int v) {
    setState(() {
      variable = v;
      current_selected_page = "AllProducts";
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
