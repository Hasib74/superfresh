import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Dialog/dialog.dart';
import 'package:supper_fresh_stores/Library/Counter.dart';

class ProductDiscription extends StatefulWidget {
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

  ProductDiscription(
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
      this.catagory_id});

  @override
  _ProductDiscriptionState createState() => _ProductDiscriptionState();
}

class _ProductDiscriptionState extends State<ProductDiscription> {
  var price;

  int quantity = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print("Priceeeeeeeeeeeeeeee  ${widget.price}");

    setState(() {
      price = widget.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Common.background_color,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: ListView(
              children: <Widget>[
                _top(),
                _description(),
                //    _comments(),
              ],
            ),
          ),
          bottom_bar(),
        ],
      ),
    );
  }

  _top() {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2 + 100,
            decoration: BoxDecoration(
              color: Common.background_color,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: new Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              InkWell(
                onTap: () {
                  print("Favourite....");

                  favoutie();
                },
                child: Common.gmail != null
                    ? StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child(Common.favourite)
                            .child(Common.gmail?.replaceAll(".", "") ?? "")
                            .child("${widget.child}${widget.id}")
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container();
                          } else {
                            if (snapshot.data == null) {
                              return new Icon(
                                Icons.favorite_border,
                                color: Common.orange_color,
                              );
                            } else {
                              return new Icon(
                                Icons.favorite,
                                color: Common.orange_color,
                              );
                            }
                          }

                          /* return new Icon(
                      Icons.favorite_border,
                      color: Common.orange_color,
                    );*/
                        })
                    : Opacity(
                        opacity: 0.5,
                        child: new Icon(
                          Icons.favorite_border,
                          color: Common.orange_color,
                        ),
                      ),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 45.0,
            left: 10,
            child: Text(
              widget.name,
              style: TextStyle(
                  color: Color(0xff3E3E3F),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5),
            )),
        Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  // Container(
                  //   child: StarRating(
                  //       rating: widget.rating != null
                  //           ? double.parse(widget.rating.toString())
                  //           : 0,
                  //       spaceBetween: 0.0,
                  //       starConfig: StarConfig(
                  //         fillColor: Colors.yellow,
                  //         size: 15,
                  //
                  //         // other props
                  //       )),
                  // ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${widget.rating != null ? widget.rating : 0}",
                    style: TextStyle(
                        color: Color(0xffB4B3B1), fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Counter(
                      initialValue: quantity,
                      minValue: 1,
                      maxValue: 100,
                      step: 1,
                      decimalPlaces: 1,
                      onChanged: (value) {
                        // get the latest value from here
                        setState(() {
                          quantity = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  bottom_bar() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(color: Common.background_color, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2),
        ]),
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Text(
              "    ${int.parse(quantity.toString()) == 0 ? 1 : int.parse(quantity.toString()) * double.parse(widget.price.toString())} tk",
              style: TextStyle(
                  color: Common.orange_color,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Common.gmail != null
                ? StreamBuilder(
                    stream: FirebaseDatabase.instance
                        .ref()
                        .child(Common.chart)
                        .child(Common.gmail?.replaceAll(".", "") ?? "")
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      } else {
                        List<String> _id = [];

                        List<String> _child_list = [];
                        var productChartBefor = 0;

                        if (snapshot.data == null) {
                          return Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Common.orange_color,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  _add_to_chart();
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      " Add To Cart ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          Map _chart = snapshot.data as Map;

                          _chart.forEach((k, v) {
                            print("Valueeeee  $v");
                            _id.add(v["id"]);

                            _child_list.add(v["child"]);
                          });

                          return Container();

                          /* for (int i = 0; i < _id.length; i++) {
                            */ /*   print(
                                "Child.........................  ${_child_list[i]}  ${widget.child} ==  ${_id[i]} ${widget.id} ");
*/ /*
                            if (_id[i] == widget.id &&
                                widget.child == _child_list[i]) {
                              productChartBefor = 1;
                            }
                          }
                          if (productChartBefor == 1) {
                            return Opacity(
                              opacity: 0.6,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Common.orange_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Add To Cart ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Common.orange_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    _add_to_chart();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_shopping_cart,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Add To Cart ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }*/
                        }
                      }
                    })
                : Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Common.orange_color,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _add_to_chart();
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              " Add To Cart ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              width: 15,
            ),

            //TODO  i have to chnage it later

            /*   InkWell(
              onTap: () {},
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Common.orange_color,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        " Order Now ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              width: 10,
            ),*/
          ],
        ),
      ),
    );
  }

  _description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.discreption,
        style: TextStyle(
            color: Color(0xff989A9E), fontSize: 16, letterSpacing: 0.3),
      ),
    );
  }

  _comments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Comments",
            style: TextStyle(
                color: Color(0xff5B5B5B),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child("${widget.child}")
                .child(widget.id)
                .child("Comments")
                .onValue,
            builder: (context, snp) {
              if (snp.data == null || snp.data == null || snp.data == null) {
                return Container();
              } else {
                Map<dynamic, dynamic> _comments =
                    snp.data as Map<dynamic, dynamic>;

                // print(_comments.values.toList());

                List<String> commentsList = [];
                List<String> gmailList = [];
                List<String> imageList = [];
                List<String> nameList = [];
                List<double> ratingList = [];

                if (_comments != null) {
                  _comments.forEach((k, v) {
                    print(v["comments"]);
                    commentsList.add(v["comments"]);
                    gmailList.add(v["gmail"]);
                    imageList.add(v["image"]);
                    nameList.add(v["name"]);
                    ratingList.add(v["rating"]);
                  });

                  // return Container();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _comments.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(imageList[index])),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          nameList[index],
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          gmailList[index],
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    // Container(
                                    //   child: StarRating(
                                    //       rating: ratingList[index],
                                    //       spaceBetween: 0.0,
                                    //       starConfig: StarConfig(
                                    //         fillColor: Colors.yellow,
                                    //         size: 15,
                                    //
                                    //         // other props
                                    //       )),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    commentsList[index],
                                    style: TextStyle(
                                        color: Color(0xff989A9E), fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
                // return Container();
              }
            }),
      ],
    );
  }

  void _add_to_chart() {
    Common.isRegister().then((isRegister) {
      print(isRegister);

      if (isRegister) {
        print("Your are registred before");

        Common.get_user().then((gmail) {
          FirebaseDatabase.instance
              .ref()
              .child(Common.chart)
              .child(gmail?.replaceAll(".", "") ?? "")
              .once()
              .then((v) {
            if (v.snapshot == null) {
              FirebaseDatabase.instance
                  .ref()
                  .child(Common.chart)
                  .child(gmail?.replaceAll(".", "") ?? "")
                  .push()
                  .set({
                //  "catagory_id":widget.catagory_id
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
                "buy_price": price.toString(),
                "quantiry": quantity.toString()
              }).then((_) {
                print("Add product to chart");
              });
            } else {
              print("Not Nullllllllllllllllllllllllllllll   ");

              List<String> _id = [];

              List<String> _child_id = [];

              Map<dynamic, dynamic> _chart =
                  v.snapshot.value as Map<dynamic, dynamic>;

              var productChartBefor = 0;

              _chart.forEach((k, v) {
                print("Valueeeee  $v");
                _id.add(v["id"]);

                _child_id.add(v["child"]);
              });

              /*   for (int i = 0; i < _chart.length; i++) {
                if (_chart[i] != null) {

                  print("${_chart[i]["id"] }         =====             ${widget.id}");

                  if (_chart[i]["id"] == widget.id && widget.child == _chart[i]["child"]) {
                    productChartBefor = 1;
                  }
                }
              }*/

              for (int i = 0; i < _id.length; i++) {
                if (_id[i] == widget.id && _child_id[i] == widget.child) {
                  productChartBefor = 1;
                }
              }

              if (productChartBefor == 0) {
                print("Category               id  ${widget.catagory_id}");
                Common.get_user().then((gmail) {
                  FirebaseDatabase.instance
                      .reference()
                      .child(Common.chart)
                      .child(gmail?.replaceAll(".", "") ?? "")
                      .once()
                      .then((v) {
                    FirebaseDatabase.instance
                        .reference()
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
                      "buy_price": price.toString(),
                      "quantiry": quantity.toString()
                    });
                  }).then((_) {
                    print("Add product to chart");
                  });
                });
              } else {
                print("Product alrady added to chart");
              }
            }
          });
        });
      } else {
        print("Your did not registared before");

        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                LogInAndRegistationPageDialog(
                  child: widget.child,
                  image: widget.image,
                  name: widget.name,
                  id: widget.id,
                  previous_price: widget.previous_price,
                  price: widget.price,
                  discreption: widget.discreption,
                  offer: widget.offer,
                  rating: widget.rating,
                  catagory_id: widget.catagory_id,
                  state: Common.chart,
                  buy_price: widget.price,
                  quantity: quantity,
                )));
      }
    });
  }

  void favoutie() {
    FirebaseDatabase.instance
        .reference()
        .child(Common.favourite)
        .child(Common.gmail?.replaceAll(".", "") ?? "")
        .child("${widget.child}${widget.id}")
        .once()
        .then((v) {
      if (v.snapshot.exists) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .child("${widget.child}${widget.id}")
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
          "buy_price": price.toString(),
          "quantiry": quantity.toString()
        }).catchError((err) =>
                print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr  $err"));
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .child("${widget.child}${widget.id}")
            .remove()
            .then((_) {
          print("Favoutite is deleted");
        });
      }
    }).catchError((err) => print(err));
  }

/*void openDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new LogInAndRegistationPageDialog();
        },
        fullscreenDialog: true));
  }*/
}
