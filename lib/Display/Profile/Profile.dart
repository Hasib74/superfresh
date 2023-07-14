import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Dialog/dialog.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("initState ");
  }

  @override
  Widget build(BuildContext context) {
    print("onBuild ");
/*
    Common.isLogIn().then((value) => print(
        "Log in infoooooooooooooooooooooooooooooooooooooooooooo  ${value}"));*/

    print("Okk");

    return Scaffold(
        body: Common.gmail == null
            ? Center(
                child: InkWell(
                  onTap: () {


                    goToSecondScreen(context);

                    /*Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            LogInAndRegistationPageDialog(
                              current_state: "profile",
                            )));*/
                  },
                  child: Text(
                    "Sign In Or Sing Up",
                    style: TextStyle(
                        color: Common.orange_color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : profile_display());
  }






  void goToSecondScreen(_context)async {
    var result = await Navigator.push(_context, new MaterialPageRoute(
      builder: (BuildContext context) =>
      new LogInAndRegistationPageDialog(
        current_state: "profile",
      ),
      fullscreenDialog: true,)
    );

    print(result);

   // Scaffold.of(_context).showSnackBar(SnackBar(content: Text("$result"),duration: Duration(seconds: 3),));

  }

  profile_display() {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child(Common.user)
            .child(Common.gmail?.replaceAll(".", "")??"")
            .child(Common.basic_info)
            .child("login")
            .onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data == null) {
            return Container();
          } else {
            return snapshot.data?.snapshot.value == "true"
                ? new Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          image(),
                          list(),
                        ],
                      ),
                      name(),
                      edit_button(),
                    ],
                  )
                : Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                LogInAndRegistationPageDialog(
                                  current_state: "profile",
                                )));
                      },
                      child: Text(
                        "Sign In Or Sing Up",
                        style: TextStyle(
                            color: Common.orange_color,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
          }
        });
  }

  name() {
    return Positioned(
      top: MediaQuery.of(context).size.width - 138,
      left: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //   Text("User Name",style: TextStyle(color: Color(0xff292929),fontSize: 17,fontWeight: FontWeight.bold),),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(Common.user)
                  .child(Common.gmail?.replaceAll(".", "")??"")
                  .child(Common.basic_info)
                  .child("name")
                  .onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snap) {
                if (snap.data == null) {
                  return Container();
                } else {
                  return Text(
                    snap.data?.snapshot.value.toString() ?? "User Name",
                    style: TextStyle(
                        color: Color(0xffFEFEFE),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  );
                }
              })
        ],
      ),
    );
  }

  edit_button() {
    return Positioned(
      top: MediaQuery.of(context).size.width - 128,
      right: 10,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
        backgroundColor: Common.orange_color,
      ),
    );
  }

  list() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView(
          children: <Widget>[
            //number(),

            Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: 8,
            ),

            email(),

            Divider(
              color: Colors.black12,
            ),
            /*  SizedBox(
              height: 8,
            ),
*/
            //   address(),

            Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: 8,
            ),

            // Divider(color: Colors.black12,),
          ],
        ),
      ),
    );
  }

  image() {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child(Common.user)
            .child(Common.gmail?.replaceAll(".", "") ??"")
            .child(Common.basic_info)
            .child("Image")
            .onValue,
        builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
          print("Gmail.....  ${Common.gmail}");

          // print(snapshot.data.snapshot.value);

          if (snapshot.data == null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 100,
            );
          } else {
            return new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      snapshot.data?.snapshot.value.toString() ??"",
                    )),
              ),
            );
          }
        });
  }

  number() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Number",
            style: TextStyle(
                color: Color(0xff292929),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(Common.user)
                  .child(Common.gmail?.replaceAll(".", "") ??"")
                  .child(Common.basic_info)
                  .child("phone")
                  .onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snap) {
                if (snap.data == null) {
                  return Container();
                } else {
                  return Text(
                    snap.data?.snapshot.value.toString() ??"",
                    style: TextStyle(color: Color(0xffD3D3D3)),
                  );
                }
              })
        ],
      ),
    );
  }

  email() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: TextStyle(
                color: Color(0xff292929),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(Common.user)
                  .child(Common.gmail?.replaceAll(".", "") ??"")
                  .child(Common.basic_info)
                  .child("email")
                  .onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snap) {
                if (snap.data == null) {
                  return Container();
                } else {
                  return Text(
                    snap.data?.snapshot.value.toString() ??"",
                    style: TextStyle(color: Color(0xffD3D3D3)),
                  );
                }
              })
        ],
      ),
    );
  }

  address() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Address",
            style: TextStyle(
                color: Color(0xff292929),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(Common.user)
                  .child(Common.gmail?.replaceAll(".", "") ??"")
                  .child(Common.basic_info)
                  .child("Address")
                  .onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snap) {
                if (snap.data == null) {
                  return Container();
                } else {
                  return Text(
                    snap.data?.snapshot.value.toString() ?? "",
                    style: TextStyle(color: Color(0xffD3D3D3)),
                  );
                }
              })
        ],
      ),
    );
  }
}
