import 'package:flutter/material.dart';
class paddingButtons extends StatelessWidget {
  paddingButtons({ this.color , this.text, this.func});

  Color? color;
  String? text;
  VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: func,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            "$text",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
