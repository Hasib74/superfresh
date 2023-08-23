import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/Order/ShippingInfo.dart';
import 'package:supper_fresh_stores/Library/Counter.dart';
import 'package:http/http.dart' as http;
import 'package:supper_fresh_stores/Model/Address.dart';

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  //var quantity;

  //var total_price=0.0;

  final FirebaseMessaging? firebaseMessaging = FirebaseMessaging.instance;

  String? adminToken;

  String serverToken =
      "AAAAYRdQILY:APA91bFzhd7EoGvrXC8Z6-FrbtAEvvSwzb0MtDZQrUzwkzsFmRp94cK_J0ChBWBMSvB309n-CcfsckMPemjoVrQopmb45SVgguUOupj3FeCMswEmmzBf3zv20adhZmirCmGOE5JgdxZt";

  String? _name;
  String? _address;

  String? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserDetails().then((_user_list) {
      print(_user_list);

      setState(() {
        _name = _user_list[0];

        _address = _user_list[1];

        _image = _user_list[2];

        print("Name  $_user_list");

        print(_address);

        print(_image);
      });
    });

    _adminToken()?.then((v) {
      setState(() {
        adminToken = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        appBar: AppBar(
          backgroundColor: Color(0xffF6F6F6),
          elevation: 0.0,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: new Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
        ),
        body: Common.gmail != null
            ? Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: list(),
                  ),
                  bottom_bar()
                ],
              )
            : Center(
                child: Text(
                  "Please Sing up or log in first",
                  style: TextStyle(color: Common.orange_color),
                ),
              ));
  }

  _image_display(image) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      width: 65,
      height: 65,
    );
  }

  bottom_bar() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(color: Common.background_color, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2),
        ]),
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child(Common.chart)
                .child(Common.gmail!.replaceAll(".", ""))
                .onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.data?.snapshot == null ||
                  snapshot.data == null ||
                  snapshot.hasError == true) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Price : 0.0 tk",
                        style: TextStyle(
                            color: Common.orange_color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Opacity(
                        opacity: 0.6,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Common.orange_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    " Order Now ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                List<String> priceList = [];

                var price = 0.0;

                Map<dynamic?, dynamic>? prices;

                Object? _obj = snapshot.data?.snapshot.value;

                if (_obj is Map<dynamic, dynamic>) {
                  prices = _obj.cast<dynamic?, dynamic?>();
                }

                print("Prices type  $_obj");

                prices?.forEach((k, v) {
                  if (v != null) {}
                  priceList.add(v!["price]"].toString());
                });

                for (int i = 0; i < priceList.length; i++) {
                  price +=
                      priceList[i].toString() == "null" ? 0 : double.parse(priceList[i]);
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Price : $price tk",
                        style: TextStyle(
                            color: Common.orange_color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          //_order();
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    contentPadding: EdgeInsets.all(0.0),
                                    content: ShippingInfo(),
                                  )).then((value) {
                            if (value != null) {
                              print("Returned Value is  $value");
                              _order(value);
                            }
                          });
                        },
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Common.orange_color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  " Order Now ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  list() {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child(Common.chart)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snp) {
          if (snp.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snp.data == null ||
                snp.data == null ||
                snp.hasData == false ||
                snp.data == null ||
                snp.hasError) {
              return Container();
            } else {
              List<String> _price = [];
              List<String> _catagory_id = [];
              List<String> _child = [];
              List<String> _discription = [];
              List<String> _id = [];
              List<String> _image = [];
              List<String> _offer = [];
              List<String> _quantity = [];
              List<String> _rating = [];

              List<String> _name = [];

              List<String> _key = [];

              List<String> _buy_price = [];

              Map<dynamic, dynamic>? _chart;
              if (snp.data?.snapshot.value is Map<dynamic, dynamic>) {
                _chart = snp.data?.snapshot.value as Map<dynamic, dynamic>;
              }

              _chart?.forEach((k, v) {
                print("Keyyyy  $k");

                print("Valueee  $v");

                _price.add(v["price"].toString());
                _catagory_id.add(v["catagory_id"].toString());
                _child.add(v["child"].toString());
                _discription.add(v["discription"].toString());
                _image.add(v["image"].toString());
                _name.add(v["name"].toString());
                _offer.add(v["offer"].toString());
                _quantity.add(v["quantiry"].toString());
                _rating.add(v["rating"].toString());
                _buy_price.add(v["buy_price"].toString());

                _key.add(k);
              });

              return ListView.builder(
                  itemCount: _name.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              //TODO image
                              _image_display(_image[index]),
                              SizedBox(
                                width: 10,
                              ),

                              //TODO name catagory price quanity
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _name[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  StreamBuilder(
                                      stream: FirebaseDatabase.instance
                                          .ref()
                                          .child(Common.category)
                                          .child(_catagory_id[index])
                                          .child("name")
                                          .onValue,
                                      builder: (context,
                                          AsyncSnapshot<DatabaseEvent>
                                              snapshot) {
                                        if (snapshot.data == null) {
                                          return Container();
                                        } else {
                                          return Text(
                                              "${snapshot.data?.snapshot.exists == false ? "" : snapshot.data?.snapshot.value.toString()}",
                                              style: TextStyle(
                                                  color: Color(0xff868686),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold));
                                        }
                                      }),
                                  Text(
                                    "${_price[index]} tk",
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("Quantity : ${_quantity[index]}"),
                                ],
                              ),
                              Spacer(),
                              // _delete_count(quantity,_quantity,index),

                              //TODO image delete button +count
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child(Common.chart)
                                            .child(Common.gmail
                                                    ?.replaceAll(".", "") ??
                                                "")
                                            .child(_key[index])
                                            .remove()
                                            .then((_) {
                                          print("Deleted successfully...");
                                        });
                                      },
                                      child: Icon(Icons.delete_outline)),

                                  //Spacer(),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  count(
                                    quantity:
                                        int.parse(_quantity[index].toString()),

                                    ongetQuantity: ((count) {
                                      FirebaseDatabase.instance
                                          .ref()
                                          .child(Common.chart)
                                          .child(Common.gmail
                                                  ?.replaceAll(".", "") ??
                                              "")
                                          .child(_key[index])
                                          .update({
                                        "quantiry": count,
                                        "price":
                                            (double.parse(_buy_price[index]) *
                                                    count)
                                                .toString()
                                      }).then((_) {
                                        print("Updated");
                                      });
                                    }),

                                    // key: Charts().key,
                                  ),
                                  //  Counter(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        });
  }

  void _order(Address address) {
    FirebaseDatabase.instance
        .reference()
        .child(Common.order)
        .child(Common.gmail?.replaceAll(".", "") ?? "")
        .child(Common.shipping_address)
        .set({
      "House Number": address.house_number,
      "Road Number": address.road_number,
      "Zip Code": address.zip_code,
      "Thana Name": address.thana_name,
    });

    FirebaseDatabase.instance
        .ref()
        .child(Common.chart)
        .child(Common.gmail?.replaceAll(".", "") ?? "")
        .once()
        .then((v) {
      Map<dynamic, dynamic>? _carty_list =
          v.snapshot.value as Map<dynamic, dynamic>;

      _carty_list.forEach((k, v) {
        FirebaseDatabase.instance
            .ref()
            .child(Common.order)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .push()
            .set({
              "buy_price": v["buy_price"],
              "catagory_id": v["catagory_id"],
              "child": v["child"],
              "discription": v["discription"],
              "image": v["image"],
              "name": v["name"],
              "price": v["price"],
              "quantiry": v["quantiry"],
              "rating": v["rating"],
            })
            .catchError((err) => print(err))
            .then((_) {
              FirebaseDatabase.instance
                  .ref()
                  .child(Common.chart)
                  .child(Common.gmail?.replaceAll(".", "") ?? "")
                  .child(k)
                  .remove()
                  .then((_) {
                print("Sending notification... ");

                sendAndRetrieveMessage().then((value) {
                  Map<String, dynamic> _v = value;

                  _v.forEach((k, v) {
                    print("Key  $k");
                    print("Value $v");
                  });
                });
              });

              //_sendNotifictation();
            });
      });
    });
  }

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    await http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'New Order from  $_name',
            'title': 'New Order'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'type': 'order_send',
            'name': _name,
            'address': _address,
            'image': _image
          },
          'to': '$adminToken',
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    return completer.future;
  }

  Future<List<String>> _getUserDetails() async {
    List<String> _user_list = [];

    await FirebaseDatabase.instance
        .ref()
        .child(Common.user)
        .child(Common.gmail?.replaceAll(".", "") ?? "")
        .child(Common.basic_info)
        .once()
        .then((DatabaseEvent user) {
      if (user.snapshot.value != null) {
        Map<dynamic, dynamic> _user =
            user.snapshot.value as Map<dynamic, dynamic>;
        print("Valueeeeeeeeeeeeeeee ${user.snapshot.value}");

        _user_list.add(_user["name"] ?? "");

        _user_list.add(_user["Address"] ?? "");

        _user_list.add(_user["Image"] ?? "");
      }
    });

    return _user_list;
  }

  Future<String?>? _adminToken() async {
    String? token;

    await FirebaseDatabase.instance
        .ref()
        .child("Token")
        .child("Admin")
        .child("token")
        .once()
        .then((v) {
      token = v.snapshot.value.toString();
    }).catchError((err) => print(err));

    return token;
  }
}

//Count library function create

typedef getQuantity = int? Function(int quantity);

class count extends StatefulWidget {
  var quantity;

  getQuantity? ongetQuantity;

  count({this.quantity, Key? key, this.ongetQuantity}) : super(key: key);

  @override
  _countState createState() => _countState();
}

class _countState extends State<count> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _current_quantity = widget.quantity;

    widget.quantity = _current_quantity;
  }

  var _current_quantity;

  @override
  Widget build(BuildContext context) {
    return Counter(
      initialValue: _current_quantity,
      minValue: 1,
      maxValue: 100,
      step: 1,
      decimalPlaces: 1,
      buttonSize: 20,
      icons_size: 13,
      fonts_size: 10,
      onChanged: (value) {
        // get the latest value from here

        // print("Count valueee  ${value}");

        if (widget.ongetQuantity != null) {
          widget.ongetQuantity!(value);
        }

        setState(() {
          _current_quantity = value;

          widget.quantity = value;
        });
      },
    );
  }
}
