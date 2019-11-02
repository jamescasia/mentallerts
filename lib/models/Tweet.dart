import 'SentimentState.dart';
class Tweet {
  String content;
  String timestamp;
  String refId;

  Map<String, dynamic> toJson() => {
        "content": content,
        "timestamp": timestamp,
        "refId": refId,
      };

  Tweet.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        timestamp = json['timestamp'],
        refId = json['refId'];
}
