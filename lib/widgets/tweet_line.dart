import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1,),
      padding: EdgeInsets.only(left: 3),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "You make me feel special!!! 세상이 아무리 날 주저앉혀도아프고 아픈 말들이 날 찔러도",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 1,
            child: Icon(
              FontAwesomeIcons.sadTear,
              size: 25,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
