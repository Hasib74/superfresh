import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:supper_fresh_stores/Registation/Registation_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var _email_controller = new TextEditingController();
  var _password_controller = new TextEditingController();


  var _isPressLogIn=false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _top(),
              _bottom()

            ],
          ),
        ),
      ),
    );
  }


  Widget _top(){

    return Positioned(
      top: 0.0,
      child: Stack(
       children: <Widget>[
         Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height / 2 + 50,
           decoration: BoxDecoration(
             color: Color.fromRGBO(255, 255, 255, 0.19),
             image: DecorationImage(
                 colorFilter: new ColorFilter.mode(
                     Colors.black.withOpacity(1), BlendMode.dstATop),
                 fit: BoxFit.cover,
                 image: AssetImage("Img/grosory.jpeg")),
           ),


           child: BackdropFilter(
             filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
             child: Container(



             ),
           ),
         ),


       /*  Positioned(
           top: 50,

           child: Column(

             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[

               Opacity(
                 opacity: 0.8,

                 child: Text("Super",style: TextStyle(
                   color: Colors.white,

                   fontSize: 60,

                   fontWeight: FontWeight.bold

                 ),),
               ),


               Opacity(


                 opacity: 0.8,
                 child: Text("Fresh",style: TextStyle(
                     color: Colors.white,

                     fontSize: 60,

                     fontWeight: FontWeight.bold

                 ),),
               ),


               Opacity(


                 opacity: 0.8,
                 child: Text("Stores",style: TextStyle(
                     color: Colors.grey[100],

                     fontSize: 60,

                     fontWeight: FontWeight.bold

                 ),),
               )


             ],

           ),
         )*/

       ],
      )
    );

  }


  Widget _bottom(){

    return  Positioned(
        bottom: 0.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Color(0xffF7F7F7),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _isPressLogIn ?  _otpCode()  :_logIn() ,
          ),
        )
    );

  }



  Widget _logIn(){

    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Login to your account",
            style: TextStyle(
                color: Color(0xff172E4B),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        Padding(
          padding:
          const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius:
                  BorderRadius.all(Radius.circular(50)),
                ),
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
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  borderRadius:
                  BorderRadius.all(Radius.circular(50)),
                ),
                child: TextField(
                  controller: _password_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              new Text(
                "Forgot your password?",
                style: TextStyle(color: Color(0xff5C5C5C)),
                textAlign: TextAlign.right,
              )
            ],
          ),
        ),
        Spacer(),
        InkWell(

          onTap: (){


            setState(() {


              _isPressLogIn=true;


            });


          },

          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(color: Color(0xffFF5126)),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                    color: Color(0xffFDEBE3),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Spacer(),
        Center(
          child: new Container(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) =>
                              RegistationPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Color(0xffCFD0D5)),
                    ),
                    Text(
                      "Sing Up",
                      style: TextStyle(color: Color(0xffF5A180)),
                    ),
                  ],
                ),
              )),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );

  }

  Widget _otpCode(){

    return Column(
crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[


        SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "OTP",
            style: TextStyle(
                color: Color(0xff172E4B),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),


        SizedBox(
          height: 25,
        ),

       Padding(
         padding: const EdgeInsets.all(10.0),
         child: Container(

           padding: EdgeInsets.all(10),
           child: Center(

             child: PinPut( inputDecoration: InputDecoration(
               focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xffFF5126), width: 1.0),
               ),
               enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xffFF5126), width: 1.0),
               ),

             ), onSubmit: (v)=>print(v), fieldsCount: 4,),

           ),
         ),
       )


      ],

    );

  }



}
