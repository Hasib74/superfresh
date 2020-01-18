import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Model/Order.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<Order> _order_list = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Common.gmail != null) {
      print("Gmail.....................   ${Common.gmail}");

      FirebaseDatabase.instance
          .reference()
          .child(Common.order)
          .child(Common.gmail.replaceAll(".", ""))
          .once()
          .then((value) {
        Map<dynamic, dynamic> _order = value.value;

        _order.forEach((k, v) {
          print("Keyyyyyyyyyyyyyyy   ${k}");

          print("Valueeeeeeeeeeeeeeeeeeee  ${v}");

          setState(() {
            _order_list.add(new Order(
                child: v["child"],
                rating: v["rating"],
                price: v["price"],
                id: k,
                image: v["image"],
                name: v["name"],
                buy_price: v["buy_price"],
                catagory_id: v["catagory_id"],
                discription: v["discription"],
                quantiry: v["quantiry"]));
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _order_list != null
        ? list()
        : Center(
            child: Text("You have no order"),
          );
  }

  list() {
    return ListView.builder(
        itemCount: _order_list.length,
        shrinkWrap: true,
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

                    _image_display(_order_list[index].image),

                    SizedBox(
                      width: 10,
                    ),

                    //TODO name catagory price quanity
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _order_list[index].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .reference()
                                .child(Common.category)
                                .child(_order_list[index].catagory_id)
                                .child("name")
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                return Text(
                                    snapshot.data.snapshot.value == null
                                        ? ""
                                        : snapshot.data.snapshot.value,
                                    style: TextStyle(
                                        color: Color(0xff868686),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold));
                              }
                            }),
                        Text(
                          "\$${_order_list[index].price}",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Quantity : ${_order_list[index].quantiry}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
}
