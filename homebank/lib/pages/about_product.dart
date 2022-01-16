import 'package:flutter/material.dart';
import 'package:home_bank/model/bucket.dart';
import 'package:home_bank/model/product.dart';

class AboutProduct extends StatefulWidget {
  Product product;
  Bucket bucket;

  AboutProduct({this.product, this.bucket});

  @override
  State<AboutProduct> createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 180,
                    child: Image.network(widget.product.urlImg),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${widget.product.price} т',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${widget.product.title} т',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF2F3E61),
                    borderRadius: BorderRadius.circular(8)),
                child: TextButton(
                  onPressed: () {
                    widget.bucket.addToBucket([
                      widget.product.getId(),
                      widget.product.getPrice(),
                      widget.product.getTitle(),
                      widget.product.geturlImg()
                    ]);
                    print("product in bucket");
                    widget.bucket
                        .addToTotal(double.parse(widget.product.price));
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'Добавить в корзину ${widget.bucket.totalAmount} ${widget.bucket.productsCount()}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
