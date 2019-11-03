import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'MentallertUser.dart';
import 'Sentiment.dart';

class AppModel extends Model {
  List<MentallertUser> mentallertUsers;
  Sentiment meanSentiment;
  Sentiment modeSentiment;

  searchUser(String handle) async {
    //Press the search button
    if (await userExists(handle)) {
    } else {}
  }

  userExists(String handle) async {}

  buildMentallertUserFromNetwork(String handle) {
    // MentallertUser mU = MentallertUser.fromNetwork(handle);
  }
  press() async {
    print("yawa");
    print((await fetchPost()).body);
  }

  Future<http.Response> fetchPost() {
    return http.get(
        'https://tweets-api.azurewebsites.net/get-tweets?user=love_CamelleG');
  }
}
