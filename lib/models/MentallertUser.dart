import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Sentiment.dart';
import 'package:stats/stats.dart';

class MentallertUser {
  String handle;
  String name;
  String profileLink;
  String displayPhotoLink;
  String displayPhotoPath;
  var timeAdded;

  double overallSentiment = 0;
  Sentiment sentiment;
  MentallertUser();

  List<MentallertTweet> mentallertTweets = [];

  fetchInitialTweetsFromNetwork() async {
    // print(await getSentimentTweets(handle));

    var list = await getSentimentTweets(handle) as List;
    if (list.length > 0) {
      List<MentallertTweet> rList = list
          .map((i) => MentallertTweet.fromNetwork(i)..setTweetSentiment())
          .toList();
      mentallertTweets = rList;
    } else
      mentallertTweets = <MentallertTweet>[];
  }

  fetchNewTweetsFromNetwork() async {
    print(await getSentimentTweets(handle));

    var list = await getNewSentimentTweets(handle) as List;
    if (list.length > 0) {
      List<MentallertTweet> rList = list
          .map((i) => MentallertTweet.fromNetwork(i)..setTweetSentiment())
          .toList();
      mentallertTweets = rList + mentallertTweets;
    }
  }

  setSentiment() {
    Map<Sentiment, int> counts = {

      Sentiment.Happy: 0,
      Sentiment.Neutral:0,
      Sentiment.Sad: 0
    };

    for(MentallertTweet t in mentallertTweets){

      counts[t.sentiment]+=1; 

    }
    sentiment =(counts[Sentiment.Happy] >=counts[Sentiment.Neutral] &&counts[Sentiment.Happy] >=counts[Sentiment.Sad]   )? Sentiment.Happy:(counts[Sentiment.Neutral] >=counts[Sentiment.Happy] &&counts[Sentiment.Neutral] >=counts[Sentiment.Sad]   )?Sentiment.Neutral: Sentiment.Sad;
 
    
  }

  Map<String, dynamic> toJson() => {
        "handle": handle,
        "name": name,
        "profileLink": profileLink,
        "displayPhotoPath": displayPhotoPath,
        "displayPhotoLink": displayPhotoLink,
        "overallSentiment": overallSentiment,
        "sentiment": sentiment,
        "timeAdded": timeAdded,
        "mentallertTweets": mentallertTweets.map((f) => f.toJson()).toList(),
      };
  factory MentallertUser.fromStorageJson(Map<String, dynamic> json) {
    var mU = MentallertUser()
      ..handle = json["handle"]
      ..name = json["name"]
      ..profileLink = json["profileLink"]
      ..displayPhotoLink = json["displayPhotoLink"]
      ..timeAdded = json["timeAdded"]
      ..displayPhotoPath = json['displayPhotoPath']
      ..overallSentiment = json["overallSentiment"]
      ..sentiment = json['sentiment'];

    var list = json['mentallertTweets'] as List;
    if (list.length > 0) {
      List<MentallertTweet> rList =
          list.map((i) => MentallertTweet.fromStorageJson(i)).toList();
      mU.mentallertTweets = rList;
    } else
      mU.mentallertTweets = <MentallertTweet>[];
    return mU;
  }
  // factory MentallertUser.fromStorageJson(Map<String, dynamic> json){}
  // : handle = json["handle"],
  //   name = json["name"],
  //   profileLink = json["profileLink"],
  //   displayPhotoLink = json["displayPhotoLink"],
  //   displayPhotoPath = json['displayPhotoPath'],
  //   overallSentiment = json["overallSentiment"],
  //   sentiment = json['sentiment'];

  factory MentallertUser.fromNetwork(Map<String, dynamic> json) {
    var mU = MentallertUser()
      ..handle = json["handle"]
      ..name = json["name"]
      ..profileLink = json["profile"]
      ..displayPhotoLink = json["dplink"]
      ..timeAdded = DateTime.now().millisecondsSinceEpoch;

    return mU;

    // var list = json['mentallertTweets'] as List;
    // if (list.length > 0) {
    //   List<MentallertTweet> rList =
    //       list.map((i) => MentallertTweet.fromStorageJson(i)).toList();
    //   mU.mentallertTweets = rList;
    // } else
    //   mU.mentallertTweets = <MentallertTweet>[];
    // return mU;
  }

  // MentallertUser.fromNetwork(Map<String, dynamic> json)
  //     : handle = json["handle"],
  //       name = json["name"],
  //       profileLink = json["profileLink"],
  //       displayPhotoLink = json["displayPhotoLink"],
  //       displayPhotoPath = json['displayPhotoPath'];
  // overallSentiment = json["overallSentiment"],
  // sentiment = json['sentiment'];

  getTweets(handle) async {
    return (json.decode((await http.get(
            'https://mentalert.azurewebsites.net/get-tweets?user=${handle}'))
        .body));
  }

  getNewSentimentTweets(handle) async {
    return (json.decode((await http.get(
            'https://mentalert.azurewebsites.net/tweets-sentiment?user=${handle}&num=30&timestamp=${DateTime.now().millisecondsSinceEpoch.toString()}'))
        .body));
  }

  getSentimentTweets(handle) async {
    return (json.decode((await http.get(
            'https://mentalert.azurewebsites.net/tweets-sentiment?user=${handle}&num=15'))
        .body));
  }
}

class MentallertTweet {
  String content;
  String timeAdded;

  double sentimentValue = 0;
  Sentiment sentiment;

  setTweetSentiment() {
    {
      sentiment = (sentimentValue > 0.85)
          ? Sentiment.Happy
          : (sentimentValue < 0.25) ? Sentiment.Sad : Sentiment.Neutral;
    }
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "sentimentValue": sentimentValue,
        "sentiment": sentiment,
        "timeAdded": timeAdded,
      };

  MentallertTweet.fromStorageJson(Map<String, dynamic> json)
      : content = json["content"],
        sentimentValue = json["sentimentValue"],
        sentiment = json["sentiment"],
        timeAdded = json['timeAdded'];

  MentallertTweet.fromNetwork(Map<String, dynamic> json)
      : content = json["text"],
        sentimentValue = json["score"],
        // sentiment = json["score"],
        timeAdded = json['time'];
}
// import 'package:mentallerts/models/MentallertTweet.dart';
// import 'package:mentallerts/models/SentimentState.dart';
// import 'TwitterUser.dart';
// import 'Sentiment.dart';

// class MentallertUser {
//   TwitterUser twitterUser;
//   Sentiment sentiment;
//   List<MentallertTweet> mentallertTweets;

//   MentallertUser() {}

//   buildFromNetwork(String handle) async {

//     // twitterUser.

//   }

//   addTweets(){

//   }

//   MentallertUser_fromNetwork(String handle) async{
//     // todo build user from everything
//     // MentallertUser mU = MentallertUser()
//     // ..twitterUser =await TwitterUser_fromNetwork(handle)
//     // ..
//     // return mU;

//     // TwitterUser tU = await TwitterUserchec
//     // ..buildFromNetwork(handle);

//   }

//   Map<String, dynamic> toJson() => {
//         'twitterUser': twitterUser,
//         'sentiment': sentiment,
//         "mentallertTweets": mentallertTweets.map((f) => f.toJson()).toList(),
//       };
//   factory MentallertUser.fromStorageJson(Map<String, dynamic> json) {
//     var mU = MentallertUser()
//       ..twitterUser = json['twitterUser']
//       ..sentiment = json['sentiment'];
//     var list = json['mentallertTweets'] as List;
//     if (list.length > 0) {
//       List<MentallertTweet> rList =
//           list.map((i) => MentallertTweet.fromStorageJson(i)).toList();
//       mU.mentallertTweets = rList;
//     } else
//       mU.mentallertTweets = <MentallertTweet>[];
//     return mU;
//   }
// }
