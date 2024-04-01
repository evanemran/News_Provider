import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_provider/models/news_model.dart';

final topHeadlines = StateProvider<List<NewsModel>>((ref) => []);

final topHeadlinesBusiness = StateProvider<List<NewsModel>>((ref) => []);
final topHeadlinesSports = StateProvider<List<NewsModel>>((ref) => []);
final topHeadlinesEntertainment = StateProvider<List<NewsModel>>((ref) => []);
final topHeadlinesHealth = StateProvider<List<NewsModel>>((ref) => []);
final topHeadlinesScience = StateProvider<List<NewsModel>>((ref) => []);
final topHeadlinesTechnology = StateProvider<List<NewsModel>>((ref) => []);