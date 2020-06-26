import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      yield* _mapAddtEventToState(event.post, event.image, event.extenstion);
    } else if (event is LoadPosts) {
      yield* _mapLoadPostsToState();
    }
  }

  Stream<PostState> _mapLoadPostsToState() async* {
    _postSubscription?.cancel();
    _postSubscription = PostRepository.getAllPosts()
        .listen((posts) => UpdatePosts(posts: posts));
  }

  Stream<PostState> _mapAddtEventToState(
      Post post, Uint8List imageBytes, String extenstion) async* {
    yield PostUploading();
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
      print('err');
      yield PostNotUploaded();
    }
  }
}
