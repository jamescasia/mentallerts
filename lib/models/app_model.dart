import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'MentallertUser.dart';
import 'Sentiment.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AppModel extends Model {
  List<MentallertUser> mentallertUsers;
  Sentiment meanSentiment;
  Sentiment modeSentiment;

  StreamController addUserStreamController = StreamController();

  AppModel() {
    addUserStreamController.add(AddingUserStates.Neutral);
  }

  searchUser(String handle) async {
    print("timestaamp is " + DateTime.now().millisecondsSinceEpoch.toString());

    //Press the search button

    addUserStreamController.add(AddingUserStates.LoadingSearch);
    var res = await userExists(handle);
    if (res) {
      print("haha it exists");
      addUserStreamController.add(AddingUserStates.LoadingCheck);

      // await Future.delayed(Duration(seconds: 2));
      buildMentallertUserFromNetwork(handle);

      addUserStreamController.add(AddingUserStates.Neutral);

      // if(AddingUserState)
    } else {
      print("haha it doesnt");
      addUserStreamController.add(AddingUserStates.Cross);
    }
  }

  userExists(String handle) async {
    return (json.decode((await http.get(
                    'https://tweets-api.azurewebsites.net/user-exists?user=${handle}'))
                .body))["exist"]
            .toString()
            .toLowerCase() ==
        "true";
  }

  userDetails(String handle) async {
    return (json.decode((await http.get(
            'https://tweets-api.azurewebsites.net/user-details?user=${handle}'))
        .body));
  }

  buildMentallertUserFromNetwork(String handle) async {
    print(await userDetails(handle));

    // MentallertUser mU = MentallertUser.fromNetwork(handle);
  }

  press() async {
    // print("yawa");add
    // print((await getTweets()).body);
  }

  Future<http.Response> getTweets(handle) {
    return http
        .get('https://tweets-api.azurewebsites.net/get-tweets?user=${handle}');
  }
  // bool
}

// https://tweets-api.azurewebsites.net/get-tweets?user=love_camelleg
// https://tweets-api.azurewebsites.net/user-exists?user=love_camelleG
// https://tweets-api.azurewebsites.net/user-details?user=James46407787
// https://tweets-api.azurewebsites.net/tweets-after?user=James46407787&timestamp=0

enum AddingUserStates { Neutral, LoadingSearch, LoadingCheck, Cross }

// class AddingUserState {

// }

// class AddingUserState {
//   bool isLoading = false;
//   bool userExists = false;
//   bool addingUser = false;
//   bool initState = true;
//   AddingUserState() {

//     isLoading = false;
//     userExists = false;
//     addingUser = false;
//   }

//   AddingUserState.isLoading() {
//     isLoading = true;
//     initState = false;
//   }

//   AddingUserState.userExists() {
//     userExists = true;
//     isLoading = false;
//     initState = false;
//   }

//   AddingUserState.userNotExists() {
//     userExists = isLoading = initState = false;
//   }

//   // AddingUserState.
// }
