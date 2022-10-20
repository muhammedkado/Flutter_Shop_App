class Favorites {

  late final bool status;
  late final Null message;
  late final Data data;

  Favorites.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = null;
    data = Data.fromJson(json['data']);
  }


}

class Data {

  late final int currentPage;
  late final List<dynamic> data;
  late final String firstPageUrl;
  late final Null from;
  late final int lastPage;
  late final String lastPageUrl;
  late final Null nextPageUrl;
  late final String path;
  late final int perPage;
  late final Null prevPageUrl;
  late final Null to;
  late final int total;

  Data.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = List.castFrom<dynamic, dynamic>(json['data']);
    firstPageUrl = json['first_page_url'];
    from = null;
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = null;
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = null;
    total = json['total'];
  }

}