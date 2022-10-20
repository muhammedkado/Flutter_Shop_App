class Favorites {
  bool? status;
  dynamic message;
  Data? data;


  Favorites.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message'];
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }


}

class Data {
  int? currentPage;
  List<FavoritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = (json['data'] as List?)?.map((dynamic e) => FavoritesData.fromJson(e as Map<String,dynamic>)).toList();
    firstPageUrl = json['first_page_url'] ;
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class FavoritesData {
  int? id;
  Product? product;


  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    product = (json['product'] as Map<String,dynamic>?) != null ? Product.fromJson(json['product'] as Map<String,dynamic>) : null;
  }


}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] ;
    oldPrice = json['old_price'] ;
    discount = json['discount'];
    image = json['image'] ;
    name = json['name'] ;
    description = json['description'];
  }

}