import 'package:flutter/material.dart';
import 'package:supper_fresh_stores/Common.dart';

typedef void CounterChangeCallback(var value);

class Counter extends StatelessWidget {
  final CounterChangeCallback onChanged;

  Counter(
      {Key key,
      @required int initialValue,
      @required this.minValue,
      @required this.maxValue,
      @required this.onChanged,
      @required this.decimalPlaces,
      this.color,
      this.textStyle,
      this.step = 1,
      this.buttonSize = 23,
      this.icons_size,
      this.fonts_size})
      : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final int minValue;

  ///max value user can pick
  final int maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  int selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;
  final double icons_size;
  final double fonts_size;

  void _incrementCounter() {
    print("Incriment");

    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    print("Decriment");

    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color ?? themeData.accentColor;
    textStyle = textStyle ??
        new TextStyle(
          fontSize: 20.0,
        );

    return new Container(
      padding: new EdgeInsets.all(0.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          new SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              onPressed: _decrementCounter,
              elevation: 0.5,
              heroTag: 'a',
              tooltip: 'Decrement',
              child: Icon(
                Icons.remove,
                size: icons_size == null ? null : icons_size,
              ),
              backgroundColor: Common.orange_color,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          new Container(
            padding: EdgeInsets.all(4.0),
            child: new Text('${selectedValue}',
                style: TextStyle(
                    color: Common.orange_color,
                    fontWeight: FontWeight.bold,
                    fontSize: fonts_size == null ? null : 17)),
          ),
          SizedBox(
            width: 5,
          ),
          new SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              elevation: 0.5,
              heroTag: 'b',
              tooltip: 'Increment',
              child: Icon(
                Icons.add,
                size: icons_size == null ? null : icons_size,
              ),
              backgroundColor: Common.orange_color,
            ),
          ),
        ],
      ),
    );
  }
}
