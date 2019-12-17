import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Library/Counter.dart';

class Charts extends StatefulWidget {
  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  //var quantity;

  //var total_price=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Common.gmail!=null ?  Stack(
        children: <Widget>[
          
          
          
          
          Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: list(),
          ),
          bottom_bar()
        ],
      ):Center(
        
        child: Text("Please Sing up or log in first"),
        
      )
    );
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
                .reference()
                .child(Common.chart)
                .child(Common.gmail.replaceAll(".", ""))
                .onValue,
            builder: (context, snapshot) {

           //   print("Dattttttttttttttttttttttttttttttttttaaa  ${snapshot.data.snapshot.value}");

              if (snapshot.data.snapshot.value == null  ||  snapshot.data==null) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Price : \$ 0.0",
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
                List<String> price_list = new List();

                var price = 0.0;

                Map<dynamic, dynamic> prices = snapshot.data.snapshot.value;

                prices.forEach((k, v) {
                  price_list.add(v["price"]);
                });

                for (int i = 0; i < price_list.length; i++) {
                  price += double.parse(price_list[i]);
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total Price : \$${price}",
                        style: TextStyle(
                            color: Common.orange_color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
            .reference()
            .child(Common.chart)
            .child(Common.gmail.replaceAll(".", ""))
            .onValue,
        builder: (context, snp) {


         // print("Snapppppppppppppppppppppppppppppppppppp  ${snp.data}");


        //  print("Gmaillllll  ${Common.gmail}");


       //   print("Snapshot data...................  ${snp.data.snapshot.value}");

          if (snp.data.snapshot.value == null  || snp.data==null || snp.hasData==false || snp==null || snp.data.snapshot==null) {
            return Container();
          } else {



            List<String> _price = new List();
            List<String> _catagory_id = new List();
            List<String> _child = new List();
            List<String> _discription = new List();
            List<String> _id = new List();
            List<String> _image = new List();
            List<String> _offer = new List();
            List<String> _quantity = new List();
            List<String> _rating = new List();

            List<String> _name = new List();

            List<String> _key = new List();

            List<String> _buy_price = new List();


            Map<dynamic,dynamic> _chart = snp.data.snapshot.value;


            _chart.forEach((k,v){


              print("Keyyyy  ${k}");


              print("Valueee  ${v}");


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

 /*           Map<dynamic,dynamic> _chart = snp.data.snapshot.value;







           // print("Printtttttttttttttttttttttttttt  ${_chart[2]}");




            //List<String> _price=new List();
            List<String> _quantity = new List();
            List<String> _rating = new List();

            List<String> _name = new List();

            List<String> _key = new List();

            List<String> _buy_price = new List();

            _chart.forEach((k, v) {
              print("key..... ${k}");
              print("Value..... ${v.value}");

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
            });*/

        //   return Container();

            //  _total_price.clear();

            //  totalPrice(_price);

            //   _total_price=_price;

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
                                        .reference()
                                        .child(Common.category)
                                        .child(_catagory_id[index])
                                        .child("name")
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null) {
                                        return Container();
                                      } else {
                                        return Text(
                                            snapshot.data.snapshot.value==null? "" : snapshot.data.snapshot.value,
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold));
                                      }
                                    }),
                                Text(
                                  "\$${_price[index]}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child(Common.chart)
                                          .child(
                                              Common.gmail.replaceAll(".", ""))
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
                                  quantity: int.parse(_quantity[index].toString()),

                                  ongetQuantity: ((count) {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child(Common.chart)
                                        .child(Common.gmail.replaceAll(".", ""))
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
        });
  }
}

typedef getQuantity = int Function(int quantity);

class count extends StatefulWidget {
  var quantity;

  getQuantity ongetQuantity;

  count({this.quantity, Key key, this.ongetQuantity}) : super(key: key);

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

        widget.ongetQuantity(value);
        setState(() {
          _current_quantity = value;

          widget.quantity = value;
        });
      },
    );
  }
}
