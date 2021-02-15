
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter_app/network/token.dart';

//
Future<Map<String, dynamic>> fetchRequestSingle(String adress,String params) async {
  var token = new Token().getTokken();
  var paramsAndToken = token+"/"+params;

  final response =
      await http.get(Uri.http(adress,paramsAndToken));

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body) ;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

 Future<dynamic> fetchRequestMultiple(String adress,String params) async {
  var token = new Token().getTokken();
  var paramsAndToken = token+"/"+params;
  final response =
      await http.get(Uri.http(adress,paramsAndToken));

  if (response.statusCode == 200) {

    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body) ;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

