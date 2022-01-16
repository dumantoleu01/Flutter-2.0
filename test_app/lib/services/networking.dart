import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/constants.dart';

class Networking {
  Future<dynamic> getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print("1");
        return data;
      } else {
        return "No data";
      }
    } catch (err) {
      return "Internet connection lost";
    }
  }
}
