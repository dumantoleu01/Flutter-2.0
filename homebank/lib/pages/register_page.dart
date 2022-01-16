import 'package:flutter/material.dart';
import 'package:home_bank/components/networking.dart';
import 'package:home_bank/model/user.dart';
import 'package:home_bank/pages/scan_qr_code.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  User user;
  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Вход',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: TextField(
                    controller: _phoneController,
                    onChanged: (text) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF8FAFD),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      hintText: '+7 (___) ___-__-__',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    onChanged: (text) {},
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF8FAFD),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      hintText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF2F3E61),
                    borderRadius: BorderRadius.circular(8)),
                child: FlatButton(
                  onPressed: () async {
                    Networking networking = Networking();
                    Map data = await networking.logInPost(
                        _phoneController.text, _passwordController.text);
                    user = User(
                      accessToken: data["data"]["access_token"],
                      id: data["data"]["user"]["id"],
                      name: data["data"]["user"]["fullName"],
                      phone: data["data"]["user"]["phone"],
                      email: data["data"]["user"]["email"],
                    );
                    // print(user.getName());
                    // print(user.getPhone());

                    if (user.getAccessToken() != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ScanQRCode()));
                    }
                  },
                  child: Text(
                    'Вход',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
