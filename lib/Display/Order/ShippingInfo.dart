import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';
import 'package:supper_fresh_stores/Model/Address.dart';

class ShippingInfo extends StatefulWidget {
  @override
  _ShippingInfoState createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  var _road_controller = TextEditingController();
  var _house_controller = TextEditingController();
  var _zip_controller = TextEditingController();
  var _thana_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _close(),
                Spacer(),
                _title(context),
                Spacer(),
                _payment_on_cash(context),
                _payment_by_online_banking(context),
                Spacer(),
                _addressText(),
                _text_fields(),
                Spacer(),
                _confirm_button(),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ));
  }

  Padding _payment_by_online_banking(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: Common.orange_color,
            borderRadius: BorderRadius.all(Radius.circular(45))),
        child: Center(
          child: Text(
            "Payment By Online Banking",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                !.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding _payment_on_cash(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: Common.orange_color,
            borderRadius: BorderRadius.all(Radius.circular(45))),
        child: Stack(
          children: [
            Positioned(
              left: 20.0,
              top: 10,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 17,
                  )),
            ),
            Center(
              child: Text(
                "Payment On Cash",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    !.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "Select Order Type And Pick Point",
      style: Theme.of(context).textTheme.titleLarge,
      textAlign: TextAlign.center,
    );
  }

  _addressText() {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          "Address",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  _text_fields() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _road_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Road Number',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _house_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'House Number',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _zip_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Zip Code',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _thana_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Thana Name',
              border: InputBorder.none,
            ),
          ),
        ),
        /* TextField(
          controller: _road_controller,
          decoration: new InputDecoration(
            filled: true,
            //fillColor: Colors.grey[300],
            hintText: 'House Number',
            border: InputBorder.none,
          ),
        ),*/
      ],
    );
  }

  _confirm_button() {
    return InkWell(
      onTap: () {
        if (_house_controller.value.text.isNotEmpty &&
            _road_controller.value.text.isNotEmpty &&
            _thana_controller.value.text.isNotEmpty &&
            _zip_controller.value.text.isNotEmpty) {
          Navigator.pop(
              context,
              Address(
                  house_number: _house_controller.value.text,
                  road_number: _road_controller.value.text,
                  thana_name: _thana_controller.value.text,
                  zip_code: _zip_controller.value.text));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              'Address Field can not be empty',
              style: TextStyle(color: Colors.orange),
            ),
            duration: const Duration(seconds: 1),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Common.orange_color,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  " Confirm ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }

  _close() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ),
        ),
      ],
    );
  }
}
