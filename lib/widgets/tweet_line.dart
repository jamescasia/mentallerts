import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentallerts/models/Sentiment.dart';
import 'package:mentallerts/models/MentallertUser.dart';
import 'package:mentallerts/helpers/mentallert_icons.dart';
import 'gradient_icon.dart';

class TweetLine extends StatelessWidget {
  final MentallertTweet tweet;

  TweetLine(this.tweet);
    var green_green_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.greenAccent.shade400,
        Colors.greenAccent.shade400,
      ]);

  var red_yellow_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xffFC2A2A), const Color(0xffD7DF16)]);

  var blue_red_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xff003AAE), const Color(0xffBC0064)]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 2,
      ),
      padding: EdgeInsets.only(left: 3),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              tweet.content,
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
            child: (tweet.sentiment == Sentiment.Sad)
                ? GradientIcon(
                    icon: MentallertIcons.asset_1,
                    size: 25,
                    gradient: blue_red_gradient,
                  )
                : (tweet.sentiment == Sentiment.Neutral)
                    ? GradientIcon(
                        icon: MentallertIcons.asset_3,
                        size: 25,
                        gradient: green_green_gradient,
                      )
                    : GradientIcon(
                        icon: MentallertIcons.asset_2,
                        size: 25,
                        gradient: red_yellow_gradient,
                      ),
          )
        ],
      ),
    );
  }
}
