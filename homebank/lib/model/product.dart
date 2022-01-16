class Product {
  String title;
  int id;
  String price;
  int shop_id;
  String urlImg;

  Product({this.title, this.id, this.price, this.shop_id, this.urlImg});

  String getTitle() {
    return title;
  }

  int getId() {
    return id;
  }

  String getPrice() {
    return price;
  }

  int getShopId() {
    return shop_id;
  }

  String geturlImg() {
    return urlImg;
  }
}
