import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:gradus/src/features/main/domain/news_entity.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(LoadingNewsState()) {
    on<LoadNewsEvent>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNewsEvent event, Emitter<NewsState> emit) async {
    emit(LoadingNewsState());
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('news').get();
      print(NewsEntity.fromDocumentList(snapshot.docs));
      List<NewsEntity> messages = NewsEntity.fromDocumentList(snapshot.docs);

      print('DATA: $messages');
      emit(SuccessNewsState(items: messages));
    } catch (e) {
      emit(FailureNewsState(error: e.toString()));
    }
  }
}
