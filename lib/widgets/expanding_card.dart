import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:mentallerts/pages/home_page.dart';
import 'tweet_line.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:mentallerts/helpers/mentallert_icons.dart';
import 'gradient_icon.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:mentallerts/models/MentallertUser.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'menta';

class ExpandingCard extends StatefulWidget {
  MentallertUser mU;

  ExpandingCard(this.mU);
  @override
  _ExpandingCardState createState() => _ExpandingCardState(mU);
}

// Expanding Card Data

// Twitter User
// tweets with their emotions
// graph with sentiment over time
class _ExpandingCardState extends State<ExpandingCard> {
  // double shadowOffset = 2;
  MentallertUser mU;
  _ExpandingCardState(this.mU);
  bool expanded = false;
  bool sentimentInfoBalloonShown = false;

  // var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  // var red_yellow_gradient = LinearGradient(
  //     begin: Alignment.topCenter,
  //     end: Alignment.bottomCenter,
  //     colors: [const Color(0xffFC2A2A), const Color(0xffD7DF16)]);

  // var blue_red_gradient = LinearGradient(
  //     begin: Alignment.topCenter,
  //     end: Alignment.bottomCenter,
  //     colors: [const Color(0xff003AAE), const Color(0xffBC0064)]);

  // var happy_sad_gradient = LinearGradient(
  //     begin: Alignment.topCenter,
  //     end: Alignment.bottomCenter,
  //     colors: [Colors.yellow, Colors.blue]);

  // var blue_black_gradient = LinearGradient(
  //     begin: Alignment.topCenter,
  //     end: Alignment.bottomCenter,
  //     colors: [Colors.blueGrey, Colors.blue]);

  @override
  Widget build(BuildContext context) {
    double shadowOffset = 2;
    bool expanded = false;

    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

    var red_yellow_gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xffFC2A2A), const Color(0xffD7DF16)]);

    var blue_red_gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xff003AAE), const Color(0xffBC0064)]);

    var happy_sad_gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.yellow, Colors.blue]);

    var blue_black_gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blueGrey, Colors.blueAccent]);
    return Dismissible(
      key: Key("haha"),
      background: Container(
        color: Colors.red,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Delete?",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
            Text("Delete?",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18)),
          ],
        )),
      ),
      onResize: () {},
      onDismissed: (direction) {
        setState(() {});
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 180),
        curve: Curves.easeOutExpo,
        width: screenSize.width * 0.9,
        height: (this.expanded) ? 360 : 80,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey.shade100),
            bottom: BorderSide(width: 0.5, color: Colors.grey.shade100),
          ),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              this.expanded = !this.expanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(1000)),
                                child: Container(
                                    width: 55,
                                    height: 55,
                                    // color: Colors.red,
                                    child:

                                        //  Image.asset(
                                        //   "assets/images/mina01.png",
                                        //   fit: BoxFit.fitWidth,
                                        // ),

                                        CachedNetworkImage(
                                      imageUrl: mU.displayPhotoLink,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )

                                    // Image(image: FileImage((File("assets/images/mina01.png"))),)
                                    // decoration: BoxDecoration(
                                    //   color: Colors.grey,
                                    //   shape: BoxShape.circle,
                                    // ),
                                    ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.04,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${mU.name}",
                                    style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 16,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "@${mU.handle}",
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 13,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Icon(
                              //   FontAwesomeIcons.twitter,
                              //   size: 24,
                              //   color: Colors.blue,
                              // )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          this.sentimentInfoBalloonShown = true;
                                        });
                                      },
                                      splashColor: Colors.blue,
                                      highlightColor: Colors.green,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          GradientIcon(
                                            icon: MentallertIcons.asset_1,
                                            size: 40,
                                            gradient: blue_black_gradient,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            splashColor: Colors.red,
                                            highlightColor: Colors.green,
                                            onTap: () {
                                              print("Yawa");
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "SAD",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "Montserrat",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.blue),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.infoCircle,
                                                  color: Colors.grey.shade400,
                                                  size: 13,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   right: 15,
                              //   child:(this.sentimentInfoBalloonShown)? SpeechBubble(
                              //       nipLocation: NipLocation.BOTTOM_RIGHT,
                              //       nipHeight: 20,
                              //       color: Colors.grey.shade300,
                              //       child: Container(
                              //         margin: EdgeInsets.all(3),
                              //         child: Row(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: <Widget>[
                              //               Text("Feeling Sad")
                              //               // Icon(
                              //               //   FontAwesomeIcons.twitter,
                              //               //   color: Colors.blue,
                              //               //   size: 20,
                              //               // )
                              //             ]),
                              //       )):SizedBox(width: 0.1,),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                    // color: Colors.red,
                  ),
                  Container(
                    height: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sentiment",
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500),
                        ),
                        Flex(
                          mainAxisSize: MainAxisSize.max,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    height: 80,
                                    child: Sparkline(
                                      lineWidth: 5,
                                      lineGradient: happy_sad_gradient,
                                      data: data,
                                    ))),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    MentallertIcons.attention,
                                    size: 30,
                                  ),
                                  // Icon(
                                  //   FontAwesomeIcons.phone,
                                  //   size: 20,
                                  //   color: Colors.grey,
                                  // ),
                                  // Text(
                                  //   "may be feeling down, give your friend a call",
                                  //   style: TextStyle(fontFamily: "Montserrat"),
                                  // )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 159,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   "Last 3 Tweets",
                        //   style: TextStyle(
                        //       color: Colors.grey.shade900,
                        //       fontSize: 16,
                        //       fontFamily: "Montserrat",
                        //       fontWeight: FontWeight.w500),
                        // ),
                        Column(
                          children: <Widget>[
                            TweetLine(),
                            TweetLine(),
                            TweetLine()
                          ],
                        )
                      ],
                    ),
                    // color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
