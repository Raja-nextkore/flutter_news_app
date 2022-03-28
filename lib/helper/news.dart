import 'dart:convert';

import '../model/artical_model.dart';
import 'package:http/http.dart' as http;

class News {
  final List<ArticalModel> news = [];
  Future<void> getNews() async {
    const String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=5c0f1247c16d4f1dbd315af779828b90';
    final http.Response response = await http.get(
      Uri.parse(url),
    );
    var parsedJson = jsonDecode(response.body);
    if (parsedJson['status'] == 'ok') {
      parsedJson['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticalModel articalModel = ArticalModel(
            //author: element['author'],
            title: element['title'].toString(),
            description: element['description'].toString(),
            url: element['url'].toString(),
            urlToImage: element['urlToImage'].toString(),
            content: element['content'].toString(),
            //publishedAt: element['publishedAt'].toString(),
          );

          return news.add(articalModel);
        }
      });
    }
  }
}

class Category {
  final List<ArticalModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=5c0f1247c16d4f1dbd315af779828b90';
    final http.Response response = await http.get(
      Uri.parse(url),
    );
    var parsedJson = jsonDecode(response.body);
    if (parsedJson['status'] == 'ok') {
      parsedJson['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticalModel articalModel = ArticalModel(
            //author: element['author'],
            title: element['title'].toString(),
            description: element['description'].toString(),
            url: element['url'].toString(),
            urlToImage: element['urlToImage'].toString(),
            content: element['content'].toString(),
            //publishedAt: element['publishedAt'].toString(),
          );

          return news.add(articalModel);
        }
      });
    }
  }
}
