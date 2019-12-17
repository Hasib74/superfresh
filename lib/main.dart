import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Display/HomePlate.dart';
import 'package:supper_fresh_stores/Registation/LogInpage.dart';
import 'package:supper_fresh_stores/Registation/Registation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
