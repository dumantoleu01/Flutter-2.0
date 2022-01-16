import 'dart:io';

import 'package:flutter/material.dart';
import 'package:home_bank/components/networking.dart';
import 'package:home_bank/model/bucket.dart';
import 'package:home_bank/model/product.dart';
import 'package:home_bank/model/shop.dart';
import 'package:home_bank/pages/about_product.dart';
import 'package:home_bank/pages/basket.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanProductScreen extends StatefulWidget {
  Shop shop;
  ScanProductScreen({Key key, this.shop}) : super(key: key);

  @override
  _ScanProductScreenState createState() => _ScanProductScreenState();
}

class _ScanProductScreenState extends State<ScanProductScreen> {
  Product product;
  Bucket bucket = Bucket();

  String companyNumber, productionNumber, controlNumber;
  String market;

  String qrCode;
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode barcode;
  QRViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    market = widget.shop.getTitle();
    super.initState();
  }

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
          if (barcodes.format.formatName != "QR_CODE") {
            this.barcode = barcodes;
            controller.pauseCamera();
            companyNumber = barcode.code.substring(3, 9);
            productionNumber = barcode.code.substring(9, 12);
            controlNumber = barcode.code.substring(12);

            Map data = await Networking()
                .getProductInfo(companyNumber, productionNumber, controlNumber);
            product = Product(
              title: data["data"]["title"],
              id: data["data"]["id"],
              price: data["data"]["price"],
              shop_id: data["data"]["shop_id"],
              urlImg: data["data"]["main_image"]["url"],
            );
            showModalBottomSheet(
                context: context,
                builder: (context) => AboutProduct(
                      product: product,
                      bucket: bucket,
                    ));
            controller.resumeCamera();
            print(bucket.productsCount());

            // print(barcodes.format.formatName == "QR_CODE");
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          market,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width * 0.1) / 2,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
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
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'Наведите на штрих код на товаре',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
              child: TextButton(
                onPressed: () {
                  controller.pauseCamera();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Basket(
                                bucket: bucket,
                              )));
                },
                child: Text(
                  'Перейти в корзину',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
