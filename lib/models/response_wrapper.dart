class ResponseWrapper<T> {
  String status = "";
  int totalResults = 0;
  T? articles;

  ResponseWrapper.fromJson(
      Map<String, dynamic> json, Function(dynamic) create) {
    status = json['status'];
    totalResults = json['totalResults'];

    if (json["articles"] == null) {
      articles = null;
    } else {
      articles = create(json['articles']);
    }
  }
}