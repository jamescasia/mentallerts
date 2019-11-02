import 'package:mentallerts/models/MentallertTweet.dart';
import 'TwitterUser.dart';
import 'Sentiment.dart';

class MentallertUser {
  TwitterUser twitterUser;
  Sentiment sentiment;
  List<MentallertTweet> mentallertTweets;

  MentallertUser() {}

  Map<String, dynamic> toJson() => {
        'twitterUser': twitterUser,
        'sentiment': sentiment,
        "mentallertTweets": mentallertTweets.map((f) => f.toJson()).toList(),
      };
  factory MentallertUser.fromJson(Map<String, dynamic> json) {
    var mU = MentallertUser()
      ..twitterUser = json['twitterUser']
      ..sentiment = json['sentiment'];
    var list = json['mentallertTweets'] as List;
    if (list.length > 0) {
      List<MentallertTweet> rList =
          list.map((i) => MentallertTweet.fromJson(i)).toList();
      mU.mentallertTweets = rList;
    } else
      mU.mentallertTweets = <MentallertTweet>[];
    return mU;
  }
}
