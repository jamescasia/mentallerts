import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      height: 44,
      decoration: BoxDecoration(
          color: Colors.greenAccent[400],
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Material(
        child: InkWell(
          highlightColor: Colors.greenAccent[500],
          splashColor: Colors.green,
          onTap: () {
            print("yawa");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("ADD ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Montserrat",
                      fontSize: 22)),
              Text("+",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 38))
            ],
          ),
        ),
      ),
    );
  }
}
