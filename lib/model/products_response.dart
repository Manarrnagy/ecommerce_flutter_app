import 'package:ecommerce_task3/model/product_model.dart';

class ProductsResponse{
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductsResponse({this.products, this.total, this.skip, this.limit});

  extractfromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Product>[]; //clearing the list
      json['products'].forEach((item) {
        products!.add( Product.fromJson(item));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

}