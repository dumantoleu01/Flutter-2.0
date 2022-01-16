import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_bank/components/networking.dart';
import 'package:home_bank/model/shop.dart';
import 'package:home_bank/pages/scan_product_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCode extends StatefulWidget {
  ScanQRCode({Key key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  Shop shop;
  String qrCode;
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode barcode;
  QRViewController controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((barcodes) => setState(() async {
          if (barcodes.format.formatName == "QR_CODE") {
            this.barcode = barcodes;
            if (barcode != null) {
              controller.pauseCamera();
              // print("1  " + barcode.code);
              Map data = await Networking().getShopInfo(barcode.code);
              // print(data["data"]["title"]);

              shop = Shop(
                  title: data["data"]["title"],
                  id: data["data"]["id"],
                  address: data["data"]["address"]);

              if (data != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ScanProductScreen(
                              shop: shop,
                            )));
              }
              controller.resumeCamera();
            }
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(""),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width - 157) / 2),
            child: Image.asset(
              'assets/images/logo.png',
              width: 157,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.9,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlayMargin: EdgeInsets.all(0),
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: MediaQuery.of(context).size.width * 0.5,
                borderWidth: 10,
                overlayColor: Colors.white,
                cutOutSize: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Text(
            'Отсканируйте QR-код магазина',
          ),
        ],
      ),
    );
  }
}
