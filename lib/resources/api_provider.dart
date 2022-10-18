import 'package:bloc_api/model/news_model.dart';
import 'package:dio/dio.dart';

class ApiProvider{
  final Dio _dio = Dio();
  final String url = 'https://newsapi.org/v2/everything?q=tesla&from=2022-09-18&sortBy=publishedAt&apiKey=5ea46ac5b33541c2a9c573798139e3ee';

  Future<NewsModel> fetchNewsList() async{
    try{
      Response response = await _dio.get(url);
      return NewsModel.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured: $error stacktrace: $stacktrace");
      return NewsModel.withError("Data not Found/Connection lost");
    }
  }
}