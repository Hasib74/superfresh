import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common.dart';

class HomeCategoryDisplay extends StatelessWidget {
  final Function? chnage_to_list;

  HomeCategoryDisplay({Key? key, this.chnage_to_list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  .ref()
                  .child(Common.category)
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                List<String> _image = [];

                List<String> _name = [];

                if (snapshot.data == null ||
                    snapshot.data?.snapshot.value == null) {
                  return Container();
                } else {
                  Map<dynamic, dynamic> _category =
                      snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

                  _category.forEach((k, v) {
                    _image.add(v["image"] ?? "");

                    _name.add(v["name"] ?? "");
                  });

                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _image.length,
                      itemBuilder: (context, int index) {
                        return ButtonTheme(
                          buttonColor: Color(0xffF6F6F6),
                          child: ElevatedButton(
                            // disabledColor: true,

                            onPressed: () {
                              print("Button clicked......");

                              if (chnage_to_list != null) {
                                chnage_to_list!(index);
                              }
                            },

                            //  disabledElevation:0.0 ,
                            //disabledColor: Color(0xffF6F6F6),

                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffF6F6F6),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
}
