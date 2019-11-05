import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentallerts/widgets/expanding_card.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mentallerts/helpers/scroll_behaviour.dart';
import 'package:mentallerts/models/app_model.dart';
import 'package:mentallerts/widgets/add_button.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mentallerts/widgets/reactive_button.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

var screenSize;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppModel appModel;
  var red_yellow_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xffFC2A2A), const Color(0xffD7DF16)]);

  var blue_red_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xff003AAE), const Color(0xffBC0064)]);

  var green_green_gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.greenAccent.shade400,
        Colors.greenAccent.shade400,
      ]);

  // StreamController addUserStreamController = new StreamController();

  bool addPressed = false;
  TextEditingController addUserController;
  ConfettiController _controllerTopCenter;
  @override
  void initState() {
    appModel = AppModel();
    _controllerTopCenter = ConfettiController(duration: Duration(seconds: 5));
    // TODO: implement initState
    addUserController = TextEditingController();

    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
        } else {
          appModel.addUserStreamController.add(AddingUserStates.Neutral);
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: red_yellow_gradient.colors[0].withAlpha(150),
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    screenSize = MediaQuery.of(context).size;
    return ScopedModel<AppModel>(
      model: appModel,
      child:
          ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
        return ScrollConfiguration(
          behavior: CustomScrollBehaviour(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: BoxDecoration(gradient: red_yellow_gradient),
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: screenSize.height * 0.3,
                          floating: false,
                          pinned: false,
                          backgroundColor: Colors.white.withAlpha(0),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Container(
                              // color: Colors.blue,
                              child: ListView(
                                // mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: screenSize.height * 0.12,
                                  ),
                                  Text("Your loved ones are\nfeeling today",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          fontFamily: "Montserrat")),
                                  SizedBox(
                                    height: screenSize.height * 0.01,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.smile,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body:
                        // Container(color: ,)

                        SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          // Container(color: Colors.black,width: screenSize.width, height: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            child: Container(
                              // height: 1000,
                              width: screenSize.width,
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60))),
                              child: Container(
                                // margin: EdgeInsets.symmetric(vertical: 5),
                                // color: Colors.red,
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 60,
                                        // color: Colors.red,
                                        child: Row(
                                          children: <Widget>[
                                            // Icon(
                                            //   FontAwesomeIcons.bell,
                                            //   size: 30,
                                            //   color: Colors.red,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRect(
                                      child: Column(
                                        children: <Widget>[
                                          // Divider(
                                          //     thickness: 1.0,
                                          //     color: Colors.grey.shade300),
                                          ExpandingCard(),

                                          ExpandingCard(),
                                          ExpandingCard(),
                                          ExpandingCard(),
                                          // ExpandingCard(),
                                          // ExpandingCard(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 60,
                                        // color: Colors.red,
                                        child: Center(
                                            child: (!this.addPressed)
                                                ? ReactiveButton(
                                                    height: 44,
                                                    width: 145,
                                                    borderRadius: 30,
                                                    label: "ADD +",
                                                    shadowHeight: 0,
                                                    splashColor: Colors.green,
                                                    onTaps: () {
                                                      setState(() {
                                                        this.addPressed =
                                                            !this.addPressed;
                                                      });
                                                      // print(appModel.fetchPost());
                                                    },
                                                    bgGradient:
                                                        green_green_gradient,
                                                    highlightColor:
                                                        Colors.greenAccent,
                                                  )
                                                : Container(
                                                    // color: Colors.red,
                                                    // width: 145,
                                                    // height: 44,
                                                    // decoration: BoxDec,
                                                    child: Stack(
                                                      // mainAxisSize:
                                                      //     MainAxisSize.max,
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .center,
                                                      children: <Widget>[
                                                        // Text("UAWEA"),
                                                        Container(
                                                          width: 240,
                                                          height: 38,
                                                          child: Center(
                                                            child: TextField(
                                                              controller:
                                                                  addUserController,
                                                              // maxLength: 34,

                                                              // maxLines: 1,
                                                              inputFormatters: [
                                                                LengthLimitingTextInputFormatter(
                                                                    35),
                                                              ],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: new TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontSize: 14),
                                                              autofocus: true,
                                                              onEditingComplete:
                                                                  () {
                                                                if (addUserController
                                                                        .text !=
                                                                    "") {
                                                                  appModel.searchUser(
                                                                      addUserController
                                                                          .text);
                                                                }
                                                              },
                                                              decoration:
                                                                  new InputDecoration(
                                                                      border:
                                                                          new OutlineInputBorder(
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          const Radius.circular(
                                                                              1000.0),
                                                                        ),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      hintStyle: new TextStyle(
                                                                          fontFamily:
                                                                              "Montserrat",
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600,
                                                                          fontSize:
                                                                              14),
                                                                      hintText:
                                                                          "@Twitter",
                                                                      fillColor:
                                                                          Colors
                                                                              .white70),
                                                            ),
                                                          ),
                                                        ),

                                                        StreamBuilder(
                                                            stream: appModel
                                                                .addUserStreamController
                                                                .stream,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .data ==
                                                                  AddingUserStates
                                                                      .Neutral)
                                                                return AddingUserNeutralWidget();

                                                              if (snapshot
                                                                      .data ==
                                                                  AddingUserStates
                                                                      .LoadingSearch)
                                                                return LoadingSearchWidget();

                                                              if (snapshot
                                                                      .data ==
                                                                  AddingUserStates
                                                                      .LoadingCheck)
                                                                return LoadingCheckWidget();

                                                              if (snapshot
                                                                      .data ==
                                                                  AddingUserStates
                                                                      .Cross)
                                                                return CrossWidget();
                                                            })
                                                        // appModel.searchUserDone?
                                                        // RaisedButton(
                                                        //   onPressed: () {

                                                        //   },
                                                        // )
                                                      ],
                                                    ),
                                                  ))

                                        // RaisedButton(
                                        //   // elevation: 33,
                                        //   onPressed: () {
                                        //     _controllerTopCenter.play();
                                        //   },
                                        // ),
                                        )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   top: screenSize.height * 0.25,
                //   child: Container(
                //     // color: Colors.red,
                //     height: 30,
                //     width: screenSize.width,
                //     child: Center(
                //       child: ConfettiWidget(
                //         confettiController: _controllerTopCenter,
                //         blastDirection: 3 * pi / 2, // radial value - LEFT
                //         emissionFrequency: 0.01,
                //         numberOfParticles: 5,
                //         shouldLoop: false,
                //         colors: [
                //           Colors.green,
                //           Colors.blue,
                //           Colors.pink
                //         ], // manually specify the colors to be used
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height / 3,
      color: Colors.white,
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class AddingUserNeutralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0,
    );
  }
}

class LoadingSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Transform.scale(
          scale: 0.78,
          child: Stack(
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 10,
              )
            ],
          )),
    );
  }
}

class LoadingCheckWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Transform.scale(
          scale: 0.78,
          child: Stack(
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 10,
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                    size: 22,
                  ))
            ],
          )),
    );
  }
}

class CrossWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Transform.scale(
          scale: 0.78,
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                ),
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Icon(
                    FontAwesomeIcons.times,
                    color: Colors.red,
                    size: 22,
                  ))
            ],
          )),
    );
  }
}
