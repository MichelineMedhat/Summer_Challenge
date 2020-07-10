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
      yield* _mapLoadPostsToState(event.cachedPosts);
    } else if (event is UpdatePosts) {
      yield PostsLoaded(posts: event.posts, postsEnd: event.postsEnd);
    } else if (event is FilterChanged) {
      yield* _mapFilterChangedToState(event.filter);
    } else if (event is DeletePost) {
      yield* _mapDeletePostsToState(event.post);
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

  Stream<PostState> _mapLoadPostsToState(List<Post> cachedPosts) async* {
    yield AllPostsLoading();
    if (cachedPosts.isEmpty) {
      PostRepository.disposePagination();
    }
    _postSubscription?.cancel();
    _postSubscription = PostRepository.getAllPosts().listen((fetchedPosts) =>
        add(UpdatePosts(
            posts: cachedPosts + fetchedPosts,
            postsEnd: fetchedPosts.isEmpty ||
                fetchedPosts.length < PostRepository.POSTS_LIMIT)));
  }

  Stream<PostState> _mapDeletePostsToState(Post post) async* {
    await PostRepository.deletePost(post);
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
