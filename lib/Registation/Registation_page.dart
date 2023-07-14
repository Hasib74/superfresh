import 'package:flutter/material.dart';


class RegistationPage extends StatelessWidget {
  var _name_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();
  var _confirm_password_controller = TextEditingController();
  var _phone_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              // Image.asset("Img/piza.jpg"),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sing up free account",
                  style: TextStyle(
                      color: Color(0xff172E4B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _phone_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Phone',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _password_controller,
                  obscureText: true,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _confirm_password_controller,
                  obscureText: true,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Confirm Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: Color(0xffFF5126)),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
