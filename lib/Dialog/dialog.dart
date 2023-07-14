import 'dart:io';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supper_fresh_stores/Common.dart';

class LogInAndRegistationPageDialog extends StatefulWidget {
  final child;
  final image;
  final name;
  final id;
  final price;
  final previous_price;
  final discreption;
  final offer;
  final rating;
  final index;
  final catagory_id;
  final state;
  final buy_price;
  final quantity;
  final current_state;

  LogInAndRegistationPageDialog(
      {this.previous_price,
      this.id,
      this.image,
      this.name,
      this.child,
      this.price,
      this.discreption,
      this.offer,
      this.rating,
      this.index,
      this.catagory_id,
      this.state,
      this.buy_price,
      this.quantity,
      this.current_state});

  @override
  _LogInAndRegistationPageDialogState createState() =>
      _LogInAndRegistationPageDialogState();
}

class _LogInAndRegistationPageDialogState
    extends State<LogInAndRegistationPageDialog> {
  var _email_controller = new TextEditingController();
  var _password_controller = new TextEditingController();

  //For registation cronrollers

  var _name_controller = TextEditingController();
  var _email_controller_for_registation = TextEditingController();
  var _password_controller_for_registation = TextEditingController();
  var _confirm_password_controller = TextEditingController();

  //var _phone_controller = TextEditingController();

  // var _address_controller = TextEditingController();

  double _sigmaX = 0.9; // from 0-10
  double _sigmaY = 0.9; // from 0-10
  double _opacity = 0.9;

  bool isRegistation = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File? _profile_image;
  String? _uploadedFileURL;

  bool is_loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.0),

        key: _scaffoldKey,

        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  _background(),
                  isRegistation ? _registation_page() : _loginPage(),
                  is_loading
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Common.orange_color,
                          ),
                        )
                      : Container()
                ],
              )),
        ),
        // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      ),
    );
  }

  _log_in() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
                /*  borderRadius:
                       BorderRadius.all(Radius.circular(50)),*/
              ),
              child: TextField(
                controller: _email_controller,
                decoration: new InputDecoration(
                  filled: true,
                  //fillColor: Colors.grey[300],
                  hintText: 'Email',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF7F7F7),
                /*  borderRadius:
                       BorderRadius.all(Radius.circular(50)),*/
              ),
              child: TextField(
                controller: _password_controller,
                obscureText: true,
                decoration: new InputDecoration(
                  filled: true,
                  //fillColor: Colors.grey[300],
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Text(
              "Forgot your password?",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  is_loading = true;
                });

                _log_in_button_action();
              },
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: Color(0xffFF5126)),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _back_button() {
    return Positioned(
      top: 10,
      left: 10,
      child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
    );
  }

  _background() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        color: Colors.black.withOpacity(_opacity),
      ),
    );
  }

  _sungUp() {
    return Positioned(
      bottom: 50,
      left: 50,
      right: 50,
      child: new Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              /* Navigator.of(context).push(*/
              /* new MaterialPageRoute(
                      builder: (context) =>
                          RegistationPage()));*/
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Color(0xffCFD0D5),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isRegistation = true;
                    });
                  },
                  child: Text(
                    " Sign Up",
                    style: TextStyle(
                        color: Color(0xffF5A180),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _log_in_button_action() {
    if (_email_controller.value.text.isNotEmpty &&
        _password_controller.value.text.isNotEmpty) {
      FirebaseDatabase.instance
          .reference()
          .child(Common.user)
          .child(_email_controller.value.text.replaceAll(".", ""))
          .child(Common.basic_info)
          .once()
          .then((v) {
        print(v.snapshot.value);

        if (v.snapshot.exists) {
          print(
              "Passworddddd  ${_password_controller.value.text}    ${v.snapshot.child("password").toString()}");

          if (_password_controller.value.text ==
              v.snapshot.child("password").toString()) {
            print("You are log in");

            if (widget.current_state == null) {
              _login_and_storage_to_chart();
            } else {
              _log_in_and_back_to_profile_page();
            }
          } else {
            print("Password is not matchd");

            setState(() {
              is_loading = false;
            });

            /*    _scaffoldKey.currentState.showSnackBar(
                new SnackBar(content: new Text('Wrong Password!!!')));*/

            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: new Text(
              'Wrong Password!!!',
              style: TextStyle(color: Colors.red),
            )));
          }
        } else {
          print("You are not allowed ");

          setState(() {
            is_loading = false;
          });

          /* _scaffoldKey.currentState.showSnackBar(
              new SnackBar(content: new Text('Failed To Log In !!!')));*/
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text(
            'Failed To Log In !!!',
            style: TextStyle(color: Colors.red),
          )));
        }
      });
    } else {
      print("Empty");

      setState(() {
        is_loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text(
        'Empty',
        style: TextStyle(color: Colors.red),
      )));
    }
  }

  _loginPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          _log_in(),
          _back_button(),
          _sungUp(),
        ],
      ),
    );
  }

  hooseFile() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((img) {
      setState(() {
        print("Imageeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  $img");
        _profile_image = File(img!.path);
      });
    });
  }

  Widget _top_image() {
    return new Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: new Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                //uploadFile();
                hooseFile();
              },
              child: new Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _profile_image != null
                            ? AssetImage(_profile_image!.path)
                            : AssetImage("Img/icon_student.png"))),
              ),
            ),
            ClipPath(
              clipper: new cut_image(),
              child: new Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Icon(
                      Icons.photo_size_select_actual,
                      color: Colors.deepOrangeAccent,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _registation_page() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            // Image.asset("Img/piza.jpg"),

            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sign up free account",
                style: TextStyle(
                    color: Color(0xffF7F7F7),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            _top_image(),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/
                ),
                child: TextField(
                  controller: _name_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'User Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            /*     Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  */ /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/ /*
                ),
                child: TextField(
                  controller: _phone_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Phone',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),*/
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/
                ),
                child: TextField(
                  controller: _email_controller_for_registation,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            /*  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  */ /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/ /*
                ),
                child: TextField(
                  controller: _address_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Address',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),*/

            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/
                ),
                child: TextField(
                  controller: _password_controller_for_registation,
                  obscureText: true,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  /*  borderRadius:
                               BorderRadius.all(Radius.circular(50)),*/
                ),
                child: TextField(
                  obscureText: true,
                  controller: _confirm_password_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Confirm Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _registaion_operation_and_storage_data_to_firebase();
              },
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: Color(0xffFF5126)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            Spacer(),
          ],
        ),
        _registation_back_button(),
      ],
    );
  }

  _registation_back_button() {
    return Positioned(
      top: 10,
      left: 10,
      child: InkWell(
          onTap: () {
            setState(() {
              isRegistation = false;
            });
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
    );
  }

  void _registaion_operation_and_storage_data_to_firebase() {
    if (_name_controller.value.text.isNotEmpty &&
            /* _phone_controller.value.text.isNotEmpty &&*/
            _email_controller_for_registation.value.text.isNotEmpty &&
            _password_controller_for_registation.value.text.isNotEmpty &&
            _confirm_password_controller
                .value.text.isNotEmpty /*&&
        _profile_image != null*/
        ) {
      if (_email_controller_for_registation.value.text.contains("@")) {
        if (_password_controller_for_registation.value.text.length >= 6) {
          if (_password_controller_for_registation.value.text ==
              _confirm_password_controller.value.text) {
            setState(() {
              is_loading = true;
            });

            FirebaseDatabase.instance
                .ref()
                .child(Common.user)
                .child(_email_controller_for_registation.value.text
                    .replaceAll(".", ""))
                .once()
                .then((DatabaseEvent value) {
              if (value.snapshot.value == null) {
                FirebaseDatabase.instance
                    .ref()
                    .child(Common.user)
                    .child(_email_controller_for_registation.value.text
                        .replaceAll(".", ""))
                    .child(Common.basic_info)
                    .set({
                  "email": _email_controller_for_registation.value.text,
                  "name": _name_controller.value.text,
                  "password": _password_controller_for_registation.value.text,
                  // "phone": _phone_controller.value.text,
                  // "Address": _address_controller.value.text
                }).then((_) {
                  Common.gmail = _email_controller_for_registation.value.text;

                  if (widget.current_state == null) {
                    store_to_chart();
                  } else {
                    //TODO regsiation and back to profile

                    uploadFile();
                  }
                });
              } else {
                setState(() {
                  is_loading = false;
                });
                // _scaffoldKey.currentState.showSnackBar(new SnackBar(
                //     content: new Text(
                //   'You Are Alrady Regisatred',
                //   style: TextStyle(color: Colors.red),
                // )));

                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  content: Text("You Are Alrady Regisatred"),
                ));
              }
            });
          } else {
            setState(() {
              is_loading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: new Text(
              'Password is not match',
              style: TextStyle(color: Colors.red),
            )));
          }
        } else {
          setState(() {
            is_loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text(
            'Password should be more then 5 character',
            style: TextStyle(color: Colors.red),
          )));
        }
      } else {
        setState(() {
          is_loading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: new Text(
          'Email should  contain @',
          style: TextStyle(color: Colors.red),
        )));
      }
    } else {
      setState(() {
        is_loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text(
        'Field Empty',
        style: TextStyle(color: Colors.red),
      )));
    }
  }

  void _login_and_storage_to_chart() {
    Common.store_registaterInfo_into_sp(_email_controller.value.text).then((v) {
      Common.gmail = _email_controller_for_registation.value.text;

      //  print("Storage data to sp  ${v}");

      FirebaseDatabase.instance
          .reference()
          .child(Common.chart)
          .child(_email_controller.value.text.replaceAll(".", ""))
          .once()
          .then((DatabaseEvent v) {
        if (v.snapshot.value == null) {
          FirebaseDatabase.instance
              .reference()
              .child(Common.chart)
              .child(_email_controller.value.text.replaceAll(".", ""))
              .push()
              .set({
            "id": widget.id,
            "image": widget.image,
            "name": widget.name,
            "child": widget.child,
            "price": widget.price,
            "discription": widget.discreption,
            "offer": widget.offer,
            "rating": widget.rating,
            "index": widget.index,
            "catagory_id": widget.catagory_id,
            "buy_price": widget.buy_price.toString(),
            "quantiry": widget.quantity.toString()
          }).then((_) {
            Common.gmail = _email_controller.value.text;
            FirebaseDatabase.instance
                .reference()
                .child(Common.user)
                .child(_email_controller.value.text.replaceAll(".", ""))
                .child(Common.basic_info)
                .update({"login": "true"}).then((_) {
              print("Succcessssssssssssssssssssssssssssssssssssssss");

              //Navigator.of(context).pop();

              Navigator.pop(context, "Hello world");

              setState(() {
                is_loading = false;
              });
            });
            print("Add product to chart");
          });
        } else {
          Map<dynamic, dynamic> _chart =
              v.snapshot.value as Map<dynamic, dynamic>;

          List<String> _id = [];

          var productChartBefor = 0;

          _chart.forEach((k, v) {
            print("Valueeeee  $v");
            _id.add(v["id"]);
          });

          for (int i = 0; i < _id.length; i++) {
            if (_id[i] == widget.id) {
              productChartBefor = 1;
            }
          }

          if (productChartBefor == 0) {
            Common.get_user().then((gmail) {
              FirebaseDatabase.instance
                  .ref()
                  .child(Common.chart)
                  .child(gmail?.replaceAll(".", "") ?? "")
                  .once()
                  .then((v) {
                FirebaseDatabase.instance
                    .ref()
                    .child(Common.chart)
                    .child(gmail?.replaceAll(".", "") ?? "")
                    .push()
                    .set({
                  "id": widget.id,
                  "image": widget.image,
                  "name": widget.name,
                  "child": widget.child,
                  "price": widget.price,
                  "discription": widget.discreption,
                  "offer": widget.offer,
                  "rating": widget.rating,
                  "index": widget.index,
                  "catagory_id": widget.catagory_id,
                  "buy_price": widget.buy_price.toString(),
                  "quantiry": widget.quantity.toString()
                });
              }).then((_) {
                print("Add product to chart");
              });
            });
          } else {
            print("Product alrady added to chart");

            Common.gmail = _email_controller.value.text;

            FirebaseDatabase.instance
                .reference()
                .child(Common.user)
                .child(_email_controller.value.text.replaceAll(".", ""))
                .child(Common.basic_info)
                .update({"login": "true"}).then((_) {
              print("Succcessssssssssssssssssssssssssssssssssssssss .......  ");

              //  Navigator.of(context).pop();

              setState(() {
                is_loading = false;
              });
            });

            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                content: new Text(
              'Product alrady added to chart',
              style: TextStyle(color: Colors.red),
            )));
          }
        }
      });
    }).then((_) {
      setState(() {
        is_loading = false;
      });

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/HomePlate', (Route<dynamic> route) => false);
    }).catchError((err) => print(err));
  }

  void _log_in_and_back_to_profile_page() {
    Common.store_registaterInfo_into_sp(
            _email_controller.value.text.replaceAll(".", ""))
        .then((_) {
      Common.gmail = _email_controller.value.text;

      FirebaseDatabase.instance
          .reference()
          .child(Common.user)
          .child(_email_controller.value.text.replaceAll(".", ""))
          .child(Common.basic_info)
          .update({"login": "true"}).then((_) {
        setState(() {
          is_loading = false;
        });

        Navigator.of(context).pop();
      });
    });
  }

  void store_to_chart() {
    FirebaseDatabase.instance
        .ref()
        .child(Common.chart)
        .child(_email_controller_for_registation.value.text.replaceAll(".", ""))
        .once()
        .then((v) {
      if (v.snapshot.value == null) {
        FirebaseDatabase.instance
            .ref()
            .child(Common.chart)
            .child(_email_controller_for_registation.value.text
                .replaceAll(".", ""))
            .push()
            .set({
          "id": widget.id,
          "image": widget.image,
          "name": widget.name,
          "child": widget.child,
          "price": widget.price,
          "discription": widget.discreption,
          "offer": widget.offer,
          "rating": widget.rating,
          "index": widget.index,
          "catagory_id": widget.catagory_id,
          "buy_price": widget.buy_price.toString(),
          "quantiry": widget.quantity.toString()
        }).then((_) {
          // print("Add product to chart");

          uploadFile();
        });
      } else {
        Map<dynamic, dynamic> _chart =
            v.snapshot.value as Map<dynamic, dynamic>;

        List<String> _id = [];

        var productChartBefor = 0;

        _chart.forEach((k, v) {
          print("Valueeeee  $v");
          _id.add(v["id"]);
        });

        for (int i = 0; i < _id.length; i++) {
          if (_id[i] == widget.id) {
            productChartBefor = 1;
          }
        }

        if (productChartBefor == 0) {
      /*    Common.get_user().then((gmail) {
            FirebaseDatabase.instance
                .ref()
                .child(Common.chart)
                .child(gmail?.replaceAll(".", "" ).once().then((v) {
                  FirebaseDatabase.instance
                      .ref()
                      .child(Common.chart)
                      .child(gmail.replaceAll(".", ""))
                      .child((v.value.length + 1).toString())
                      .set({
                    "id": widget.id,
                    "image": widget.image,
                    "name": widget.name,
                    "child": widget.child,
                    "price": widget.price,
                    "discription": widget.discreption,
                    "offer": widget.offer,
                    "rating": widget.rating,
                    "index": widget.index,
                    "catagory_id": widget.catagory_id,
                    "buy_price": widget.buy_price.toString(),
                    "quantiry": widget.quantity.toString()
                  });
                }).then((_) {
                  print("Add product to chart");

                  uploadFile();
                }));
          });*/
        } else {
          print("Product alrady added to chart");

          setState(() {
            is_loading = false;
          });
        }
      }
    });
  }

   uploadFile() async {
    print("AOKKKKKKKKKKKKKKKKK0");

    if (_profile_image != null) {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      var uploadTask = storageReference.putFile(_profile_image!);
      await uploadTask.whenComplete(() => null);
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;

          print("Image Urlllllllllllllll   $_uploadedFileURL ");
        });

        FirebaseDatabase.instance
            .reference()
            .child(Common.user)
            .child(_email_controller_for_registation.value.text
                .replaceAll(".", ""))
            .child(Common.basic_info)
            .update({
          "Image": _uploadedFileURL != null ? _uploadedFileURL : "",
        }).then((_) {
          print("Image upload  Success");

          if (widget.current_state == null) {
            Common.store_registaterInfo_into_sp(
                    _email_controller_for_registation.value.text)
                .then((_) {
              FirebaseDatabase.instance
                  .reference()
                  .child(Common.user)
                  .child(_email_controller_for_registation.value.text
                      .replaceAll(".", ""))
                  .child(Common.basic_info)
                  .update({"login": "true"}).then((_) {
                setState(() {
                  is_loading = false;
                });

                //  Navigator.of(context).pop();
              });

              Common.gmail = _email_controller_for_registation.value.text;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/HomePlate', (Route<dynamic> route) => false);
            });
          } else {
            Common.store_registaterInfo_into_sp(
                    _email_controller_for_registation.value.text)
                .then((_) {
              Common.gmail = _email_controller_for_registation.value.text;

              FirebaseDatabase.instance
                  .reference()
                  .child(Common.user)
                  .child(_email_controller_for_registation.value.text
                      .replaceAll(".", ""))
                  .child(Common.basic_info)
                  .update({"login": "true"}).then((_) {
                setState(() {
                  is_loading = false;
                });

                Navigator.of(context).pop();
              });
            });
          }

          // Navigator.pop(context);
        }).catchError((e) {
          print(e);
        });
      });
    } else {
      // Navigator.of(context).pop();

      print("AOKKKKKKKKKKKKKKKKK0");

      Common.store_registaterInfo_into_sp(
              _email_controller_for_registation.value.text)
          .then((_) {
        Common.gmail = _email_controller_for_registation.value.text;

        FirebaseDatabase.instance
            .reference()
            .child(Common.user)
            .child(_email_controller_for_registation.value.text
                .replaceAll(".", ""))
            .child(Common.basic_info)
            .update({"login": "true"}).then((_) {
          setState(() {
            is_loading = false;
          });

          print("Fnisheddddddddddddddddddddddddddddd");

          Navigator.of(context).pop();
        });
      });
    }
  }
}

class cut_image extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0.0, size.height / 2);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
