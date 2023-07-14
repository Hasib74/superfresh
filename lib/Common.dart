import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Common {
  static String banner = "Bannar";
  static String category = "Category";
  static String popular = "Popular";
  static String products = "Products";
  static String user = "User";
  static String basic_info = "Basic_Info";

  static String favourite = "Favourite";

  static String chart = "Chart";

  static String order = "Order";
  static String shipping_address = "Shipping Address";

  static String? gmail ;

  static Color? background_color = Color(0xffF6F6F6);
  static Color? orange_color = Color(0xffFF5126);

  static Future<String> isLogIn() async {
    var logIn = "false";

    await FirebaseDatabase.instance
        .ref()
        .child(user)
        .child(basic_info)
        .child(gmail??"")
        .once()
        .then((value) {
      logIn = value.snapshot.child("login").value.toString();
    });

    return logIn;
  }

  static Future<dynamic> store_registaterInfo_into_sp(number) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var v = sp.setString("email", number);

    return v;
  }

  static Future<bool> isRegister() async {
    bool isRegsitaer;

    SharedPreferences sp = await SharedPreferences.getInstance();

    var v = sp.getString("email");

    print("Regsitaer value  $v");

    if (v != null) {
      isRegsitaer = true;
    } else {
      isRegsitaer = false;
    }

    return isRegsitaer;
  }

  static void remove_registaer() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var v = sp.remove("email");

    print("Regsitaer value  $v");
  }

  static Future<String?> get_user() async {
    SharedPreferences? sp = await SharedPreferences.getInstance();

    return sp.getString("email");

    //print("Regsitaer value  ${v}");
  }
}
