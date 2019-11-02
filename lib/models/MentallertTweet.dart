import 'Tweet.dart';
import 'Sentiment.dart';

class MentallertTweet {
  Tweet tweet;
  Sentiment sentiment;

  Map<String, dynamic> toJson() => {
        "tweet": tweet,
        "sentiment": sentiment,
      };

  MentallertTweet.fromJson(Map<String, dynamic> json)
      : tweet = json["tweet"],
        sentiment = json['sentiment'];
}
