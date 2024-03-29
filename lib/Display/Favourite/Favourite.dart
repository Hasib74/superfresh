import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Common.gmail != null
            ? StreamBuilder(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child(Common.user)
                    .child(Common.gmail!.replaceAll(".", ""))
                    .child(Common.basic_info)
                    .child("login")
                    .onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.data == null || snapshot.data == null) {
                    return Container();
                  } else {
                    if (snapshot.data?.snapshot.value == "true") {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: StreamBuilder(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child(Common.favourite)
                                .child(Common.gmail?.replaceAll(".", "") ?? "")
                                .onValue,
                            builder: (context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                              List<String> _name_list = [];
                              List<String> _price_list = [];
                              List<String> _discription_list = [];
                              List<String> _image_list = [];
                              List<String> _rating_list = [];

                              List<String> _id_list = [];

                              List<String> _catagory_list = [];
                              //  List<String> _name=[];

                              if (snapshot.data == null ||
                                  snapshot.data == null) {
                                return Container();
                              } else {
                                Map<dynamic, dynamic>? favList;

                                if (snapshot.data?.snapshot.value
                                    is Map<dynamic, dynamic>) {
                                  favList = snapshot.data?.snapshot.value
                                      as Map<dynamic, dynamic>;
                                }

                                favList?.forEach((k, v) {
                                  _name_list.add(v["name"].toString());

                                  _price_list.add(v["price"].toString());

                                  _rating_list.add(v["rating"].toString());

                                  _image_list.add(v["image"].toString());

                                  _id_list.add(v["id"].toString());

                                  _catagory_list
                                      .add(v["catagory_id"].toString());
                                });

                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _name_list.length,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            border: Border.all(
                                                color: Colors.black12,
                                                width: 1),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              _product_image_catagoryName_rating_price(
                                                  context,
                                                  index,
                                                  _name_list[index],
                                                  _image_list[index],
                                                  _catagory_list[index],
                                                  _price_list[index]),
                                              //_offer(_popular_list[index]),
                                              // _add(_popular_list[index]),
                                              // _fav(_popular_list[index],_key[index]),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      );
                    } else {
                      return Container();
                    }
                  }
                })
            : Container());
  }

  Widget _product_image_catagoryName_rating_price(
      context, index, name, image, catagoyId, price) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name == null ? Container() : name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child(Common.category)
                          .child(catagoyId)
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        Map<dynamic, dynamic>? _data;

                        if (snapshot.data?.snapshot.value
                            is Map<dynamic, dynamic>) {
                          _data = snapshot.data?.snapshot.value
                              as Map<dynamic, dynamic>;
                        }

                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return Text(
                            _data?["name"] ?? "",
                            style: TextStyle(
                                color: Color(0xff868686),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          );
                        }
                      }),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 14,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "${price == null ? "" : price} tk",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   "4.5 tk",
                      //   style: TextStyle(
                      //     decoration: TextDecoration.lineThrough,
                      //     decorationColor: Colors.black,
                      //     decorationStyle: TextDecorationStyle.solid,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

/*_add(popular_list) {}*/
}
