import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';

import '../../models/post.dart';
import '../../repositories/post_repository.dart';
import 'bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  StreamSubscription _postSubscription;

  @override
  PostState get initialState => AllPostsLoading();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is AddPost) {
      yield* _mapAddPostEventToState(event.post, event.image, event.extenstion);
    } else if (event is LoadPosts) {
      yield* _mapLoadPostsToState();
    } else if (event is UpdatePosts) {
      yield AllPostsLoaded(posts: event.posts);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.filter);
    }
  }

  Stream<PostState> _mapFilterChangedToState(String filter) async* {
    var char = filter[0];
    filter = filter.substring(1);
    print('ana geet hena');
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

  Stream<PostState> _mapAddPostEventToState(
      Post post, Uint8List imageBytes, String extenstion) async* {
    yield PostUploading();
    if (post.status.isEmpty) {
      yield PostNotUploaded(errorMessage: "Status can't be empty!");
    } else {
      try {
        var path;
        if (imageBytes != null) {
          path = await PostRepository.uploadImageFile(
                  imageBytes,
                  post.username +
                      post.timestamp.seconds.toString() +
                      post.timestamp.nanoseconds.toString(),
                  extenstion)
              .then((value) => value.toString());
        }
        post.uri = path;
        await PostRepository.addPost(post);

        yield PostUploaded(post: post);
      } catch (err) {
        yield PostNotUploaded();
      }
    }
  }
}
