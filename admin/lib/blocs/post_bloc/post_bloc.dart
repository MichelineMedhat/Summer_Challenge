import 'dart:async';

import 'package:admin/models/post.dart';
import 'package:admin/util/validators.dart';
import 'package:bloc/bloc.dart';

import '../../repositories/post_repository.dart';
import 'bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  StreamSubscription _postSubscription;

  @override
  PostState get initialState => AllPostsLoading();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPosts) {
      yield* _mapLoadPostsToState();
    } else if (event is UpdatePosts) {
      yield AllPostsLoaded(posts: event.posts);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.filter);
    } else if (event is AddScore) {
      yield* _mapAddScoreToState(event.username, event.score, event.post);
    } else if (event is ScoreChanged) {
      yield* _mapScoreChangedToState(event.score);
    }
  }

  Stream<PostState> _mapFilterChangedToState(String filter) async* {
    var char = filter[0];
    filter = filter.substring(1);
    if (char == '#') {
      PostRepository.getHashtagsFilter(filter)
          .listen((posts) => add(UpdatePosts(posts: posts)));
    }
    if (char == '@') {
      PostRepository.getUsersFilter(filter)
          .listen((posts) => add(UpdatePosts(posts: posts)));
    }
  }

  Stream<PostState> _mapLoadPostsToState() async* {
    _postSubscription?.cancel();
    _postSubscription = PostRepository.getAllPosts()
        .listen((posts) => add(UpdatePosts(posts: posts)));
  }

  Stream<PostState> _mapAddScoreToState(String username, double score, Post post) async* {
    await PostRepository.addScore(username, score, post);
    _mapLoadPostsToState();
  }

  Stream<PostState> _mapScoreChangedToState(double score) async* {
     Validators.isValidScore(score.toString());
  }
}
