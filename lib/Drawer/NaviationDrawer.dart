import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/HomePlate.dart';
import 'package:supper_fresh_stores/MyStore/MyStore.dart';

class NavigationDrawer extends StatelessWidget {
  // final key;

  Function closeDrawer;

  Function fun_home;
  Function fun_chart;
  Function fun_order;
  Function fun_profile;

  //Function fun_profile;
  Function fun_fav;

  Function fun_all_product;

  //Function fun_profile;

  NavigationDrawer(Key key, this.closeDrawer, this.fun_fav, this.fun_home,
      this.fun_profile, this.fun_chart, this.fun_all_product)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          width: MediaQuery.of(context).size.width / 1.8,
          height: MediaQuery.of(context).size.height,
          child: Center(
            // alignment: Alignment.centerRight,

            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
/*
              crossAxisAlignment: CrossAxisAlignment.center,

              mainAxisAlignment: MainAxisAlignment.values[5],*/
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Image(
                    image: AssetImage(
                      "Img/superfresh.png",
                    ),
                    width: 100,
                    height: 100,
                  )),

                  SizedBox(
                    height: 35,
                  ),

                  InkWell(
                    onTap: () {
                      //new HomePlate(current_state: "profile",);

                      // Navigator.of(context).pop();
                      closeDrawer();

                      fun_home();

                      print("Homeeeee");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                            "Img/home.png",
                          ),
                          width: 20,
                          height: 20,
                          color: Common.orange_color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Home",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      closeDrawer();

                      fun_chart();
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                            "Img/cart.png",
                          ),
                          width: 20,
                          height: 20,
                          color: Common.orange_color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Shoping Cart",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      //closeDrawer;

                      closeDrawer();
                      fun_fav();

                      //Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                            "Img/favourite.png",
                          ),
                          width: 20,
                          height: 20,
                          color: Common.orange_color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Favourite",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      closeDrawer();

                      fun_all_product();
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.playlist_add_check,
                          size: 28,
                          color: Common.orange_color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Products",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      closeDrawer();

                      fun_profile();
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.perm_identity,
                          size: 28,
                          color: Common.orange_color,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Profile",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //TODo need to update latter

                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.directions_car,
                        size: 28,
                        color: Common.orange_color,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Shipper",
                          style: TextStyle(
                              color: Common.orange_color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.chat,
                        size: 25,
                        color: Common.orange_color,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Chat",
                          style: TextStyle(
                              color: Common.orange_color,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.store_mall_directory,
                        size: 28,
                        color: Common.orange_color,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          closeDrawer();

                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => MyStore()));
                        },
                        child: new Text("My Store",
                            style: TextStyle(
                                color: Common.orange_color,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Common.gmail == null
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Common.remove_registaer();

                            FirebaseDatabase.instance
                                .reference()
                                .child(Common.user)
                                .child(Common.gmail.replaceAll(".", ""))
                                .child(Common.basic_info)
                                .update({"login": "false"}).then((_) {
                              Common.gmail = null;
                            });

                            closeDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                    "Img/logout.png",
                                  ),
                                  width: 20,
                                  height: 20,
                                  color: Common.orange_color,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Log Out",
                                    style: TextStyle(
                                        color: Common.orange_color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8)),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 15,
            right: 15,
            child: InkWell(
                onTap: () {
                  // this.

                  closeDrawer();
                },
                child: Icon(
                  Icons.close,
                  color: Common.orange_color,
                )))
      ],
    ));
  }
}
