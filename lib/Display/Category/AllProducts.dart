import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/ProductDiscription.dart';
import 'package:supper_fresh_stores/Model/Category.dart';
import 'package:supper_fresh_stores/Model/Product.dart';

class AllProducts extends StatefulWidget {
  final index;

  AllProducts({this.index});

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  ScrollController _scrollController = new ScrollController();

  bool isload = false;

  List<String> _tem_category = [];
  var seleted_postion = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _length().then((v) {
      // print("Valueeeeeeeeeeeeeeeeeeeeeeee  ${v}");

      setState(() {
        isload = true;

        if (widget.index == null) {
          _tabController =
              new TabController(length: v.length, vsync: this, initialIndex: 0);
        } else {
          _tabController = new TabController(
              length: v.length, vsync: this, initialIndex: widget.index);
        }

        print(v[0]);

        setState(() {
          _tem_category = v;
        });
      });
    });
  }

  //var possition;

  var scroll_direction;

  String _prev_search_text = "";
  String _search_text = "";

  @override
  Widget build(BuildContext context) {
    print("index is  ${widget.index}");

    if (isload == true) {
      _scrollController.addListener(() {
        print(_scrollController.position.userScrollDirection);

        if (_scrollController.position.userScrollDirection.toString() ==
            "ScrollDirection.forward") {
          print("forward");

          setState(() {
            scroll_direction = "forward";
          });
        } else {
          print("reverse");

          setState(() {
            scroll_direction = "reverse";
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: Stack(
        children: <Widget>[
          isload ? tabs() : Container(),
          isload ? list_view() : Container(),
        ],
      ),
    );
  }

  tabs() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xffF6F6F6), boxShadow: [
        BoxShadow(
            color: Colors.black54, blurRadius: 4, offset: Offset(0.20, 0.20))
      ]),
      child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child(Common.category)
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                List<Category> _catagory_list = [];

                if (snapshot.data == null) {
                  return Container();
                } else {
                  Map<dynamic, dynamic> catagory =
                      snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

                  catagory.forEach((k, v) {
                    _catagory_list
                        .add(new Category(categoryId: k, name: v["name"]));
                  });

                  return TabBar(
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    onTap: (possition) {
                      setState(() {
                        seleted_postion = possition;
                      });
                    },
                    tabs: _catagory_list.map<Widget>((catagory) {
                      return Container(
                        height: 25,
                        decoration: BoxDecoration(
                            color: _catagory_list.indexOf(catagory) ==
                                    _tabController?.index
                                ? Color(0xff63A6F4)
                                : Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Center(
                          child: Text(
                            "   ${catagory.name}   ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff63A6F4), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Color(0xffE9EBEE)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: TextField(
                  //controller: _text_controller,
                  onChanged: (text) {
                    print("Text  onChange $text");

                    setState(() {
                      _search_text = text;
                    });

                    setState(() {
                      /*
                        *  List _search_name=[];
  List _search_image=[];
  List _search_price=[];
  List _search_previous_price=[];
  List _search_categoryId=[];
  List _search_description=[];
  List _search_discount=[];
  List _search_id=[];
                        * */

                      /*_search_name.clear();
                        _search_image.clear();
                        _search_price.clear();
                        _search_previous_price.clear();
                        _search_categoryId.clear();
                        _search_description.clear();
                        _search_discount.clear();
                        _search_id.clear();*/
                      // _search_room_number.clear();

                      print("Text.................runing    $_search_text");

                      _prev_search_text =
                          _search_text.substring(0, _search_text.length - 1);

                      print(
                          "Text.................privious  $_prev_search_text");
                    });
                  },

                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintText: "Search Product",
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xff63A6F4),
                    ),
                    border: InputBorder.none,
                    /*  enabledBorder: const OutlineInputBorder(

                          borderSide: const BorderSide(color: Colors.blue, width: 1.0),

                        ),
*/
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  list_view() {
    return Padding(
      padding: EdgeInsets.only(top: 100, bottom: 0.0),
      child: StreamBuilder(
          stream:
              FirebaseDatabase.instance.ref().child(Common.products).onValue,
          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.data == null ||
                snapshot.data?.snapshot.value == null) {
              // print("Valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  ${snapshot.data.snapshot.value}");

              return Center(
                child: Container(),
              );
            } else {
              // print(
              //     "Valueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  ${snapshot.data.snapshot.value}");

              List _search_name = [];
              List _search_image = [];
              List _search_price = [];
              List _search_previous_price = [];
              List _search_categoryId = [];
              List _search_description = [];
              List _search_discount = [];
              List _search_id = [];

              Map<dynamic, dynamic> product =
                  snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

              List<Product> _products_list = [];

              product.forEach((k, v) {
                if (v["catagory_id"] == _tem_category[seleted_postion]) {
                  _products_list.add(
                    new Product(
                        name: v["name"],
                        image: v["image"],
                        price: v["price"],
                        previous_price: v["previous_price"],
                        categoryId: v["categoryId"],
                        description: v["description"],
                        discount: v["discount"],
                        rating: v["rating"],
                        id: k),
                  );
                }
              });

              print("Search Text...................  $_search_text");

              if (_products_list.length > 0) {
                if (_search_text != "" && _prev_search_text != _search_text) {
                  _search_name.clear();
                  _search_image.clear();
                  _search_price.clear();
                  _search_previous_price.clear();
                  _search_categoryId.clear();
                  _search_description.clear();
                  _search_discount.clear();
                  _search_id.clear();

                  for (int i = 0; i < _products_list.length; i++) {
                    if (_products_list[i]
                        .name
                        .toString()
                        .toLowerCase()
                        .contains(_search_text.toLowerCase())) {
                      // setState(() {

                      print("Monu1");

                      print(
                          "Nameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  ${_products_list[i].name.toString().toLowerCase()}       $_search_text");

                      _search_name.add(_products_list[i].name);
                      _search_image.add(_products_list[i].image);
                      _search_price.add(_products_list[i].price);
                      _search_previous_price
                          .add(_products_list[i].previous_price);
                      _search_categoryId.add(_products_list[i].categoryId);
                      _search_description.add(_products_list[i].description);
                      _search_discount.add(_products_list[i].discount);
                      _search_id.add(_products_list[i].id);
                    }
                  }
                } else {}
              }

              return _search_text == ""
                  ? GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.3),
                      ),
                      itemCount: _products_list.length,
                      itemBuilder: (context, int index) {
                        return /*_search_text=="" ? */ InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ProductDiscription(
                                      child: "Products",
                                      image: _products_list[index].image,
                                      name: _products_list[index].name,
                                      id: _products_list[index].id,
                                      price: _products_list[index].price,
                                      previous_price:
                                          _products_list[index].previous_price,
                                      discreption:
                                          _products_list[index].description,
                                      rating: _products_list[index].rating,
                                      catagory_id:
                                          _products_list[index].categoryId,
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _products_list[index].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${_products_list[index].name}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Container(
                                              //   child: StarRating(
                                              //       rating:
                                              //           _products_list[index]
                                              //                       .rating !=
                                              //                   null
                                              //               ? double.parse(
                                              //                   _products_list[
                                              //                           index]
                                              //                       .rating
                                              //                       .toString())
                                              //               : 0,
                                              //       spaceBetween: 0.0,
                                              //       starConfig: StarConfig(
                                              //         fillColor: Colors.yellow,
                                              //         size: 15,
                                              //
                                              //         // other props
                                              //       )),
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    "${_products_list[index].price} tk",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    " ${_products_list[index].previous_price} tk",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.black,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Icon(Icons.add_shopping_cart),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.3),
                      ),
                      itemCount: _search_price.length,
                      itemBuilder: (context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (context) => ProductDiscription(
                                      child: "Products",
                                      image: _search_image[index],
                                      name: _search_name[index],
                                      id: _search_id[index],
                                      price: _search_price[index],
                                      previous_price:
                                          _search_previous_price[index],
                                      discreption: _search_description[index],
                                      rating: "3.5",
                                      catagory_id: _search_categoryId[index],
                                    )));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 1)
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: new Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _search_image[index]),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${_search_name[index]}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Container(
                                              //   child: StarRating(
                                              //       rating: double.parse("3"),
                                              //       spaceBetween: 0.0,
                                              //       starConfig: StarConfig(
                                              //         fillColor: Colors.yellow,
                                              //         size: 15,
                                              //
                                              //         // other props
                                              //       )),
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Text(
                                                    "${_search_price[index]} tk",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    " ${_search_previous_price[index]} tk",
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.black,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Icon(Icons.add_shopping_cart),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            }
          }),
    );
  }

  Future<List<String>> _length() async {
    List<String> _temp_list = [];

    await FirebaseDatabase.instance
        .ref()
        .child(Common.category)
        .once()
        .then((DatabaseEvent v) {
      //    length = v.value.length;

      Map<dynamic, dynamic> catagory =
          v.snapshot.value as Map<dynamic, dynamic>;

      catagory.forEach((k, v) {
        _temp_list.add(k);
      });
    });

    return _temp_list;
  }
}
