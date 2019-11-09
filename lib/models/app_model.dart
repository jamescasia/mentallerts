import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'Sentiment.dart';
import 'MentallertUser.dart';
import 'package:flutter/material.dart';
// import 'Sentiment.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AppModel extends Model {
  Map<int, MentallertUser> mentallertUsers = {};
  List<String> mentallertUserHandles = [];
  Sentiment overallMeanSentiment;
  Sentiment overallModeSentiment;
  Sentiment finalSentiment = Sentiment.Neutral;
  BuildContext context;

  TextEditingController addUserController = TextEditingController();

  StreamController addUserStreamController = StreamController();

  AppModel(this.context) {
    addUserStreamController.add(AddingUserStates.Neutral);
  }
  dismissCard(key, handle) {
    mentallertUsers.remove(key);
    mentallertUserHandles.remove(handle);
    notifyListeners();
  }

  setOverallSentiments() {
    double sentimentSum  =0;
    double sentimentMean = 0; 
    Map<Sentiment, int> counts = {
      Sentiment.Happy: 0,
      Sentiment.Neutral: 0,
      Sentiment.Sad: 0
    };

    mentallertUsers.forEach((key, value) {
      sentimentSum += value.overallSentiment;

      counts[value.sentiment]++;
    });

    sentimentMean = sentimentSum / (mentallertUsers.length);
    overallMeanSentiment = (sentimentMean > 0.85)
        ? Sentiment.Happy
        : (sentimentMean < 0.2) ? Sentiment.Sad : Sentiment.Neutral;

    overallModeSentiment =
        (counts[Sentiment.Happy] >= counts[Sentiment.Neutral] &&
                counts[Sentiment.Happy] >= counts[Sentiment.Sad])
            ? Sentiment.Happy
            : (counts[Sentiment.Neutral] >= counts[Sentiment.Happy] &&
                    counts[Sentiment.Neutral] >= counts[Sentiment.Sad])
                ? Sentiment.Neutral
                : Sentiment.Sad;

    print("sentiments " );

    print(overallModeSentiment);
    print(overallMeanSentiment);

    finalSentiment = (overallMeanSentiment == Sentiment.Neutral) ? overallModeSentiment : overallMeanSentiment;

  
  }

  searchUser(String handle) async {
    print("timestaamp is " + DateTime.now().millisecondsSinceEpoch.toString());

    //Press the search button

    addUserStreamController.add(AddingUserStates.LoadingSearch);
    var res = await userExists(handle);
    if (res) {
      print("haha it exists");
      addUserStreamController.add(AddingUserStates.LoadingCheck);

      // await Future.delayed(Duration(milliseconds: 600));
      await buildMentallertUserFromNetwork(handle);

      addUserStreamController.add(AddingUserStates.Neutral);
      FocusScope.of(context).requestFocus(FocusNode());

      // if(AddingUserState)
    } else {
      print("haha it doesnt");
      addUserStreamController.add(AddingUserStates.Cross);
    }

    addUserController.text = "";

    addUserStreamController.add(AddingUserStates.Neutral);

    if(mentallertUsers.length >=1)setOverallSentiments();

    notifyListeners();
  }

  userExists(String handle) async {
    return (json.decode((await http.get(
                    'https://mentalert.azurewebsites.net/user-exists?user=${handle}'))
                .body))["exist"]
            .toString()
            .toLowerCase() ==
        "true";
  }

  userDetails(String handle) async {
    return (json.decode((await http.get(
            'https://mentalert.azurewebsites.net/user-details?user=${handle}'))
        .body));
  }

  buildMentallertUserFromNetwork(String handle) async {
    print(await userDetails(handle));

    MentallertUser mU = MentallertUser.fromNetwork(await userDetails(handle));
    mU.handle = handle;
    await mU.fetchInitialTweetsFromNetwork();
    print(mU.handle);
    mU.mentallertTweets.forEach((m) {
      print(m.content);
    });
    mU.setSentiment();
    appendToMentallertUsers(mU);

    // mentallertUsers.add(mU);

    // MentallertUser mU = MentallertUser.fromNetwork(handle);
  }

  appendToMentallertUsers(MentallertUser mU) {
    if (!mentallertUsers.containsKey(mU.timeAdded) &&
        !mentallertUserHandles.contains(mU.handle)) {
      mentallertUsers[mU.timeAdded] = mU;
      mentallertUserHandles.add(mU.handle);
    }
    print(mentallertUserHandles);
    print(mentallertUsers);
  }

  press() async {
    // print("yawa");add
    // print((await getTweets()).body);
  }

  Future<http.Response> getTweets(handle) {
    return http
        .get('https://mentalert.azurewebsites.net/get-tweets?user=${handle}');
  }
  // bool
}

// https://mentalert.azurewebsites.net/get-tweets?user=love_camelleg
// https://mentalert.azurewebsites.net/user-exists?user=love_camelleG
// https://mentalert.azurewebsites.net/user-details?user=James46407787
// https://mentalert.azurewebsites.net/tweets-after?user=James46407787&timestamp=0

enum AddingUserStates { Neutral, LoadingSearch, LoadingCheck, Cross }
