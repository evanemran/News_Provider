import 'dart:convert';

import 'package:news_provider/listeners/response_listener.dart';
import 'package:news_provider/models/news_model.dart';

import '../constants/apis.dart';
import '../models/response_wrapper.dart';
import 'package:http/http.dart' as http;

class RequestManager {
  void getHeadlines(String country, String category, ResponseListener<List<NewsModel>> listener) async {
    final uri =
    Uri.parse("${APIs.topHeadlines}?country=$country&category=$category&apiKey=6600726d91554031a727674028102f84");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      ResponseWrapper<List<NewsModel>> parsedResponse = ResponseWrapper<List<NewsModel>>.fromJson(
          jsonDecode(response.body),
              (data) => List<NewsModel>.from(
              data.map((x) => NewsModel.fromJson(x))));
      listener.onSuccess(parsedResponse.articles!, parsedResponse.totalResults.toString());
    } else {
      listener.onError(response.body);
      throw Exception('Failed to connect!');
    }
  }
}