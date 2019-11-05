import 'package:mentallerts/models/MentallertTweet.dart';
import 'TwitterUser.dart';
import 'Sentiment.dart';

class MentallertUser {
  TwitterUser twitterUser;
  Sentiment sentiment;
  List<MentallertTweet> mentallertTweets;

  MentallertUser() {}

  buildFromNetwork(String handle) async {

    // twitterUser.



  }

  addTweets(){

    
  }

  MentallertUser_fromNetwork(String handle) async{
    // todo build user from everything
    // MentallertUser mU = MentallertUser()
    // ..twitterUser =await TwitterUser_fromNetwork(handle)
    // ..
    // return mU;

    // TwitterUser tU = await TwitterUser()
    // ..buildFromNetwork(handle);
    
  }

  Map<String, dynamic> toJson() => {
        'twitterUser': twitterUser,
        'sentiment': sentiment,
        "mentallertTweets": mentallertTweets.map((f) => f.toJson()).toList(),
      };
  factory MentallertUser.fromStorageJson(Map<String, dynamic> json) {
    var mU = MentallertUser()
      ..twitterUser = json['twitterUser']
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
}
