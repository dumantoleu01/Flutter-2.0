class Bucket {
  double totalAmount = 0;
  dynamic products = [];

  addToBucket(dynamic list) {
    products.add(list);
  }

  clearBucket() {
    products = [];
  }

  List productsList() {
    return products;
  }

  int productsCount() {
    return products.length;
  }

  void addToTotal(double price) {
    totalAmount += price;
  }

  dynamic getData() {
    return products;
  }
}
