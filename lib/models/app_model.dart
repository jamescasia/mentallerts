import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'MentallertUser.dart';
import 'Sentiment.dart';
import 'dart:convert';

class AppModel extends Model {
  List<MentallertUser> mentallertUsers;
  Sentiment meanSentiment;
  Sentiment modeSentiment;


  bool searchUserDone = true;

  searchUser(String handle) async {
  searchUserDone = false;
    //Press the search button
    var res = await userExists(handle);
    if (res) {
      print("haha it exists");
    } else {

      print("haha it doesnt");
    }

  searchUserDone = true;
  }

  userExists(String handle) async {
    return (json.decode((await http.get(
                'https://tweets-api.azurewebsites.net/user-exists?user=${handle}'))
            .body))["exist"]  .toString().toLowerCase() == "true";
  }

  buildMentallertUserFromNetwork(String handle) {
    // MentallertUser mU = MentallertUser.fromNetwork(handle);
  }
  press() async {
    print("yawa");
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
