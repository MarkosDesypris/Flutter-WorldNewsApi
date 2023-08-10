import 'dart:convert';
import 'package:flutter_news_api/constants/api_key.dart';
import 'package:flutter_news_api/models/article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> getNews(String searchText) async {
  List<Article> news = [];
  Uri url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$searchText&apiKey=$apiKey');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);

    for (var article in jsonData['articles']) {
      Article newArticle = Article(
        author: article['author'],
        title: article['title'],
        description: article['description'],
        url: article['url'],
        urlToImage: article['urlToImage'],
        content: article['content'],
        publishedAt: article['publishedAt'],
      );
      news.add(newArticle);
    }
    return news;
  } else {
    throw Exception('Failed to load News');
  }
}

Future<List<Article>> getTopHeadlinesNews() async {
  List<Article> topHeadlinesNews = [];
  Uri url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);

    for (var article in jsonData['articles']) {
      Article newArticle = Article(
        author: article['author'],
        title: article['title'],
        description: article['description'],
        url: article['url'],
        urlToImage: article['urlToImage'],
        content: article['content'],
        publishedAt: article['publishedAt'],
      );
      topHeadlinesNews.add(newArticle);
    }
    return topHeadlinesNews;
  } else {
    throw Exception('Failed to load News');
  }
}

Future<List<Article>> getCategoriesNews(String category) async {
  List<Article> categoryNews = [];
  Uri url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);

    for (var article in jsonData['articles']) {
      Article newArticle = Article(
        author: article['author'],
        title: article['title'],
        description: article['description'],
        url: article['url'],
        urlToImage: article['urlToImage'],
        content: article['content'],
        publishedAt: article['publishedAt'],
      );
      categoryNews.add(newArticle);
    }
    return categoryNews;
  } else {
    throw Exception('Failed to load News');
  }
}
