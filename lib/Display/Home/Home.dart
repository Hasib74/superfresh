import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/HomePlate.dart';
import 'package:supper_fresh_stores/Display/ProductDiscription.dart';
import 'package:supper_fresh_stores/Model/Banner.dart';
import 'package:supper_fresh_stores/Model/Popular.dart';

class Home extends StatefulWidget {
  final Function(int) chnage_to_list;

  Home({Key key, @required this.chnage_to_list}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          _body(),
        ],
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 4,
        ),
        _banner_display(),
        SizedBox(
          height: 10,
        ),
        _catagory_display(),
        SizedBox(
          height: 10,
        ),
        _popular_display(),
      ],
    );
  }

  Widget _banner_display() {
    return StreamBuilder(
        stream:
            FirebaseDatabase.instance.reference().child(Common.banner).onValue,
        builder: (context, snapshot) {
          List<BannerM> _banner_list = new List();

          if (snapshot.data == null) {
            return Container(
              height: 150,
            );
          } else {
            Map<dynamic, dynamic> _banner = snapshot.data.snapshot.value;

            _banner.forEach((k, v) {
              _banner_list.add(new BannerM(
                  name: v["name"],
                  price: v["price"],
                  image: v["image"],
                  discount: v["discount"],
                  description: v["description"],
                  rating: v["rating"],
                  id: k.toString(),
                  catagory_id: v["id"]));
            });

            return CarouselSlider(
              height: 150,
              items: _banner_list.map((item) {
                return Builder(builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ProductDiscription(
                                image: item.image,
                                name: item.name,
                                child: "Bannar",
                                price: item.price,
                                previous_price: item.previous_price,
                                discreption: item.description,
                                offer: item.discount,
                                id: item.id,
                                rating: item.rating,
                                catagory_id: item.catagory_id,
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
                                        item.discount,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Offer",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Big Offers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "For Limited Time",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  new Container(
                                    width: 100,
                                    height: 30,
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

  Widget _catagory_display() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Category",
            style: TextStyle(
                color: Color(0xff5B5B5B),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 120,
          child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child(Common.category)
                  .onValue,
              builder: (context, snapshot) {
                List<String> _image = new List();

                List<String> _name = new List();

                if (snapshot.data == null) {
                  return Container();
                } else {
                  Map<dynamic, dynamic> _category =
                      snapshot.data.snapshot.value;

                  _category.forEach((k, v) {
                    _image.add(v["image"]);

                    _name.add(v["name"]);
                  });

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _image.length,
                      itemBuilder: (context, int index) {
                        return ButtonTheme(
                          buttonColor: Color(0xffF6F6F6),
                          child: FlatButton(
                            // disabledColor: true,

                            onPressed: () {
                              print("Button clicked......");

                              widget.chnage_to_list(index);
                            },

                            //  disabledElevation:0.0 ,
                            disabledColor: Color(0xffF6F6F6),

                            color: Color(0xffF6F6F6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_image[index])),
                                    ),
                                  ),
                                ),
                                Text(
                                  _name[index],
                                  style: TextStyle(
                                      color: Color(0xff5B5B5B), fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ],
    );
  }

  Widget _popular_display() {
    return Column(
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
                .reference()
                .child(Common.popular)
                .onValue,
            builder: (context, snapshot) {
              List<String> _key = new List();
              List<Popular> _popular_list = new List();

              if (snapshot.data == null) {
                return Container();
              } else {
                Map<dynamic, dynamic> popular = snapshot.data.snapshot.value;

                popular.forEach((k, v) {
                  _popular_list.add(new Popular(
                      name: v["name"],
                      image: v["image"],
                      price: v["price"],
                      previous_price: v["previous_price"],
                      categoryId: v["categoryId"],
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

                          print("Keyyyyyyyyyyy   ${ _key[index]}");

                          /*
                          *  ProductDiscription(
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

                          * 
                          * */

                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => ProductDiscription(
                                    previous_price: "5.6",
                                    id: _key[index],
                                    image: _popular_list[index].image,

                                   name: _popular_list[index].name,
                                   child: Common.popular,
                                   price: _popular_list[index].price,
                                   discreption: _popular_list[index].description,
                                   offer: "10",
                                   rating: "4",
                                   catagory_id:_popular_list[index].categoryId ,


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
                              Common.gmail!=null ?_fav(_popular_list[index], _key[index]):Positioned(right: 10,
                                  top: 10,child: Opacity(
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
                          .reference()
                          .child(Common.category)
                          .child(popular.categoryId)
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        } else {
                          return Text(
                            snapshot.data.snapshot.value["name"],
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
                        "\$${popular.price == null ? "" : popular.price}",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${popular.previous_price == null ? "" : popular.previous_price}",
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
        color: Color(0xffFF5126),
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
            color: Color(0xffFF5126),
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

/*

            print("Voddaa");




            if(Common.gmail==null){

              print("Nullll");
            }else{


              StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child(Common.user)
                      .child(Common.gmail.replaceAll(".", ""))
                      .child(Common.basic_info)
                      .child("login")
                      .onValue,
                  builder: (context, snapshot) {


                    print("Log in info   ${snapshot.data.snapshot.value}");

                    if (snapshot.data != null ||
                        snapshot.data.snapshot.value != null) {
                      if (snapshot.data.snapshot.value == "true") {
                        print("Clicked.....");


                      }
                    }
                  });

            }*/



          },
          child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child(Common.favourite)
                  .child("${Common.popular}${key}")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  if (snapshot.data.snapshot.value == null) {
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
        .reference()
        .child(Common.favourite)
        .child("${Common.popular}${key}")
        .once()
        .then((v) {
      if (v.value == null) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child("${Common.popular}${key}")
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
                print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr  ${err}"));
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.favourite)
            .child("${Common.popular}${key}")
            .remove()
            .then((_) {
          print("Favoutite is deleted");
        });
      }
    }).catchError((err) => print(err));
  }

/*  void favoutie(Popular  popular,key) {

    FirebaseDatabase.instance.reference().child(Common.favourite).child(key).once().then((v){


      if(v.value==null){



        FirebaseDatabase.instance.reference().child(Common.favourite).child(key).set({


          "id": key,
          "image": popular.image,
          "name": popular.name,
          "child": "Popular",
          "price":popular.price ,
          "discription": popular.description,
         // "offer": popular.offer,
          "rating": "5",

          "catagory_id": popular.categoryId,
          "buy_price": popular.price,
        //  "quantiry": popular.


        });

      }else if(v.value["child"] == "Popular"){



        FirebaseDatabase.instance.reference().child(Common.favourite).child(key).remove().then((_){


          print("Favoutite is deleted");

        });


      }


    });

  }*/

}
