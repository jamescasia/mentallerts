
class Tweet {
  String content;
  String timestamp;
  String refId;

  Map<String, dynamic> toJson() => {
        "content": content,
        "timestamp": timestamp,
        "refId": refId,
      };

  Tweet.fromNetworkJson(Map<String, dynamic> json) :
      content = json["text"],
      timestamp = json["time"],
      refId = json["tweetId"];

  Tweet.fromStorageJson(Map<String, dynamic> json)
      : content = json["content"],
        timestamp = json['timestamp'],
        refId = json['refId'];
}
 