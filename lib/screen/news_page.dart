import 'package:bloc_api/bloc/news_bloc.dart';
import 'package:bloc_api/model/news_model.dart';
import 'package:bloc_api/screen/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final NewsBloc _newsBloc = NewsBloc();
  WebViewPage webViewPage = WebViewPage();

  @override
  void initState(){
    _newsBloc.add(GetNewsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Bloc'),),
      body: _buildNewsList(),
    );
  }

  Widget _buildNewsList(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: BlocProvider(
          create: (_) => _newsBloc,
          child: BlocListener<NewsBloc,NewsState>(
              listener: (context,state){
                if(state is NewsError){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message!)
                    )
                  );
                }
              },
            child: BlocBuilder<NewsBloc,NewsState>(
                builder: (context, state){
                  if(state is NewsInitial){
                    return _buildLoading();
                  }
                  if(state is NewsLoading){
                    return _buildLoading();
                  }
                  if(state is NewsLoaded){
                    return _buildCard(context,state.newsModel);
                  }else if(state is NewsError){
                    return Container();
                  }else {
                    return Container();
                  }
                }),
          ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, NewsModel model){
    return ListView.builder(
        itemCount: model.articles!.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.all(8),
            child: Card(
              child: InkWell(
                onTap: ()=> WebViewController(context,"${model.articles![index].url}"),
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                          Image.network("${model.articles![index].urlToImage}"),
                          Text("Article: ${model.articles![index].title}"),
                          Text("Author: ${model.articles![index].author}"),
                          Text("Publish Date: ${model.articles![index].publishedAt}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
  void WebViewController(BuildContext context,String url){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> WebViewPage(url: url)));
  }
}
