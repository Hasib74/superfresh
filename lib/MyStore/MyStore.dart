import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/MyStore/confirm_order.dart';
import 'package:supper_fresh_stores/MyStore/my_order.dart';
import 'package:supper_fresh_stores/MyStore/received_order.dart';

class MyStore extends StatefulWidget {
  @override
  _MyStoreState createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  var seltected_tab = '1';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

       /* appBar: new AppBar(
          
          leading: InkWell(onTap: (){


            Navigator.of(context).pop();

          },  child:
          
        ),*/
        
        body: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

           InkWell(

             onTap: (){

               Navigator.of(context).pop();

             },

               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new  Icon(Icons.arrow_back,color: Colors.black38,),
               )),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                child: ListView(

                 // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _tab(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: seltected_tab=="1"  ?  new MyOrder() : seltected_tab=="2" ? new ConfirmOrder() : ReceivedOrder() )
          ],
        ),
      ),
    );
  }

  /*
  *
  *
  * */
  _tab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              seltected_tab = "1";
            });
          },
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              color:
                  seltected_tab == '1' ? Common.orange_color : Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_shopping_cart,
                    size: 16,
                    color: seltected_tab == "1" ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "My Order",
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            seltected_tab == "1" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              seltected_tab = "2";
            });
          },
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              color:
                  seltected_tab == '2' ? Common.orange_color : Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.check,
                    size: 16,
                    color: seltected_tab == "2" ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Confirm Order",
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            seltected_tab == "2" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              seltected_tab = "3";
            });
          },
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              color:
                  seltected_tab == '3' ? Common.orange_color : Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.home,
                    size: 16,
                    color: seltected_tab == "3" ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Received Order",
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            seltected_tab == "3" ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
