import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../Common.dart';
import '../../Model/Banner.dart';
import '../ProductDiscription.dart';

class AppBanner extends StatelessWidget {
  AppBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child(Common.banner).onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          List<BannerM> _banner_list = [];

          if (snapshot.data == null || snapshot.data?.snapshot.value == null) {
            return Container(
              height: 150,
            );
          } else {
            Map<dynamic, dynamic> _banner =
                snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

            _banner.forEach((k, v) {
              _banner_list.add(new BannerM(
                  name: v["name"] ?? "",
                  price: v["price"] ?? "",
                  image: v["image"] ?? "",
                  discount: v["discount"] ?? "",
                  description: v["description"] ?? "",
                  rating: v["rating"] ?? "",
                  id: k.toString() ?? "",
                  catagory_id: v["catagory_id"] ?? ""));
            });

            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 145,
              ),
              items: _banner_list.map((item) {
                // print(item.price);
                return Builder(builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ProductDiscription(
                                image: item.image ?? "",
                                name: item.name ?? "",
                                child: "Bannar" ?? "",
                                price: item.price ?? "",
                                previous_price: item.previous_price ?? "",
                                discreption: item.description ?? "",
                                offer: item.discount ?? "",
                                id: item.id ?? "",
                                rating: item.rating ?? "",
                                catagory_id: item.catagory_id ?? "",
                              )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(

                              /* colorFilter: new ColorFilter.mode(
                                Colors.orange.withOpacity(0.8), BlendMode.dstATop),*/
                              fit: BoxFit.cover,
                              image: NetworkImage(item.image))),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black12,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        item.discount ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Offer",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Big Offers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "For Limited Time",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  new Container(
                                    width: 100,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFF5126),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Order Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              }).toList(),
            );
          }
        });
  }
}
