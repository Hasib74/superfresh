import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/HomePlate.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async   {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  Common.get_user().then((user) {
    if (user == null) {
      runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePlate()));
    } else {
      Common.gmail = user;
      runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePlate()));
    }
  });
} /* => runApp(MaterialApp( debugShowCheckedModeBanner: false,
    home: HomePlate()));*/
