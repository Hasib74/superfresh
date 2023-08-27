
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../Common.dart';
import '../../Model/Popular.dart';
import '../ProductDiscription.dart';
class HomePopularProducts extends StatelessWidget {

  const HomePopularProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "  Popular",
          style: TextStyle(
              color: Color(0xff5B5B5B),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child(Common.popular)
                .onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              List<String> _key = [];
              List<Popular> _popular_list = [];

              if (snapshot.data == null ||
                  snapshot.data?.snapshot.value == null) {
                return Container();
              } else {
                Map<dynamic, dynamic> popular =
                snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

                popular.forEach((k, v) {
                  _popular_list.add(new Popular(
                      name: v["name"],
                      image: v["image"],
                      price: v["price"],
                      previous_price: v["previous_price"],
                      categoryId: v["catagory_id"],
                      description: v["description"],
                      discount: v["discount"]));

                  _key.add(k);
                });

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _popular_list.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => ProductDiscription(
                                previous_price: "5.6",
                                id: _key[index],
                                image: _popular_list[index].image,
                                name: _popular_list[index].name,
                                child: Common.popular,
                                price: _popular_list[index].price,
                                discreption:
                                _popular_list[index].description,
                                offer: "10",
                                rating: "4",
                                catagory_id:
                                _popular_list[index].categoryId,
                              )));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              border:
                              Border.all(color: Colors.black12, width: 1),
                            ),
                            child: Stack(
                              children: <Widget>[
                                _product_image_catagoryName_rating_price(
                                    context, index, _popular_list[index]),
                                _offer(_popular_list[index]),
                                _add(_popular_list[index]),
                                Common.gmail != null
                                    ? _fav(_popular_list[index], _key[index])
                                    : Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Opacity(
                                      opacity: 0.5,
                                      child: new Icon(
                                        Icons.favorite_border,
                                        color: Common.orange_color,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ],
    );
  }


  Widget _product_image_catagoryName_rating_price(
      context, index, Popular popular) {
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
                    fit: BoxFit.cover, image: NetworkImage(popular.image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    popular.name == null ? Container() : popular.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  StreamBuilder(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child(Common.category)
                          .child(popular.categoryId)
                          .onValue,
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.data == null ||
                            snapshot.data?.snapshot.value == null) {
                          return Container();
                        } else {
                          Map<dynamic, dynamic> _data = snapshot
                              .data?.snapshot.value as Map<dynamic, dynamic>;
                          return Text(
                            _data["name"],
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
                        "${popular.price == null ? "" : popular.price} tk",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${popular.previous_price == null ? "" : popular.previous_price} tk",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.black,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
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

  Widget _offer(Popular popular) {
    return Container(
      width: 70,
      height: 20,
      decoration: BoxDecoration(
        color: Color(0xff63A6F4),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), topLeft: Radius.circular(15)),
      ),
      child: Center(
          child: Text(
            "${popular.discount == null ? "" : popular.discount} % OFF",
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget _add(Popular popular) {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: Container(
        height: 35,
        width: 45,
        decoration: BoxDecoration(
            color: Color(0xff63A6F4),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(15))),
        child: Center(
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _fav(Popular popular, key) {
    return Positioned(
        right: 10,
        top: 10,
        child: InkWell(
          onTap: () {
            // favoutie(popular, key);

            favoutie(popular, key);
          },
          child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child(Common.favourite)
                  .child(Common.gmail?.replaceAll(".", "") ?? "")
                  .child("${Common.popular}$key")
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  if (snapshot.data?.snapshot.value == null) {
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
              }),
        ));
  }

  void favoutie(Popular popular, key) {
    FirebaseDatabase.instance
        .ref()
        .child(Common.favourite)
        .child(Common.gmail?.replaceAll(".", "") ?? "")
        .child("${Common.popular}$key")
        .once()
        .then((DatabaseEvent v) {
      if (v.snapshot.value == null) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .child("${Common.popular}$key")
            .set({
          "id": key,
          "image": popular.image,
          "name": popular.name,
          "child": "Popular",
          "price": popular.price,
          "discription": popular.description,
          // "offer": popular.offer,
          "rating": "5",

          "catagory_id": popular.categoryId,
          "buy_price": popular.price,
          //  "quantiry": popular.
        }).catchError((err) =>
            print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr  $err"));
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child(Common.gmail?.replaceAll(".", "") ?? "")
            .child("${Common.popular}$key")
            .remove()
            .then((_) {
          print("Favoutite is deleted");
        });
      }
    }).catchError((err) => print(err));
  }
}
