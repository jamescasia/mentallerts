import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AppModel extends Model {
  Future<http.Response> fetchPost() async{
    return await http.get('https://jsonplaceholder.typicode.com/posts/1');
  }
}
