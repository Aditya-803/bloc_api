import 'package:bloc_api/resources/api_provider.dart';
import '../model/news_model.dart';

class ApiRepository{
  final _provider = ApiProvider();

  Future<NewsModel> fetchNewsList(){
    return _provider.fetchNewsList();
  }
}

class NetworkError extends Error{}