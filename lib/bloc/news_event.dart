//import 'package:equatable/equatable.dart';
part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable{
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsList extends NewsEvent{}