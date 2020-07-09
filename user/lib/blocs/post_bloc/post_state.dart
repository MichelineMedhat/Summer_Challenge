import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class AllPostsLoading extends PostState {
  @override
  String toString() => 'AllPostsLoading';
}

class PostsLoaded extends PostState {
  final List<Post> posts;
  final bool postsEnd;

  const PostsLoaded({@required this.posts, @required this.postsEnd});

  @override
  List<Object> get props => [posts, postsEnd];

  @override
  String toString() {
    return 'PostsLoaded{posts: $posts, postsEnd: $postsEnd}';
  }
}

class AllPostsNotLoaded extends PostState {
  @override
  String toString() => 'AllPostsNotLoaded';
}

class PostUploading extends PostState {
  @override
  String toString() => 'PostUploading';
}

class PostUploaded extends PostState {
  final Post post;

  const PostUploaded({@required this.post});

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'PostUploaded { post: $post }';
}

class PostNotUploaded extends PostState {
  final String errorMessage;

  PostNotUploaded({this.errorMessage = "Error Uploading Post"});

  @override
  String toString() => 'PostNotUploaded';
}

class FilteringPosts extends PostState {
  @override
  String toString() => 'FilteringPosts';
}
