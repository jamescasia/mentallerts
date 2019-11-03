import 'Tweet.dart';
import 'AccountInfo.dart';

class TwitterUser {
  AccountInfo accountInfo;
  List<Tweet> tweets;
  String uid;

  TwitterUser() {}

  buildFromNetwork(Map<String, dynamic> json) async {

    // todo: set class variables from read json string
    this.uid = json["adfaf"];
    this.accountInfo = json["accountInfo"];
    // this.accountInfo = json["accountInfo"];

  }

  Map<String, dynamic> toJson() => {
        'accountInfo': accountInfo,
        'uid': uid,
        "tweets": tweets.map((f) => f.toJson()).toList(),
      };
  factory TwitterUser.fromStorageJson(Map<String, dynamic> json) {
    var tU = TwitterUser()
      ..accountInfo = json['accountInfo']
      ..uid = json['uid'];
    var list = json['tweets'] as List;
    if (list.length > 0) {
      List<Tweet> rList = list.map((i) => Tweet.fromStorageJson(i)).toList();
      tU.tweets = rList;
    } else
      tU.tweets = <Tweet>[];
    return tU;
  }
}
