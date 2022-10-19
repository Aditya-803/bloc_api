import 'package:bloc_api/resources/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/news_model.dart';
part 'news_state.dart';
part 'news_event.dart';

class NewsBloc extends Bloc<NewsEvent,NewsState>{
  NewsBloc(): super(NewsInitial()){
    final ApiRepository _apiRepository = ApiRepository();
    on<GetNewsList>((event, emit) async{
      try{
        emit(NewsLoading());
        final mList = await _apiRepository.fetchNewsList();
        emit(NewsLoaded(mList));
        if(mList.error != null){
          emit(NewsError(mList.error));
        }
      }on NetworkError{
        NewsError('unable to fetch data. Make sure you are connected to internet');
      }
    });
  }
}