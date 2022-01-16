import 'dart:convert';
import 'package:home_bank/constants.dart';
import 'package:http/http.dart';

class Networking {
  Future<dynamic> logInPost(String phone, String password) async {
    final response = await post(Uri.parse(urlLogin),
        body: {"phone": phone, "password": password});
    var data = jsonDecode(response.body);
    print(phone);
    print(urlLogin);
    print(password);
    return data;
  }

  Future<dynamic> getShopInfo(String url) async {
    final response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(url);
    print(data);
    return data;
  }

  Future<dynamic> getProductInfo(String companyNumber, String productionNumber,
      String controlNumber) async {
    final response = await get(Uri.parse(
        "$urlProduct?company_number=$companyNumber&production_number=$productionNumber&control_number=$controlNumber"));
    Map data = jsonDecode(response.body);
    print(urlProduct);
    print(data);
    return data;
  }
}
