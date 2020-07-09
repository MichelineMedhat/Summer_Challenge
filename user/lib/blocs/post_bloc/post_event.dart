import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostEvent {
  final List<Post> cachedPosts;

  LoadPosts({@required this.cachedPosts});

  @override
  List<Object> get props => [cachedPosts];

  @override
  String toString() {
    return 'LoadPosts { cachedPosts: $cachedPosts }';
  }
}

class UpdatePosts extends PostEvent {
  final List<Post> posts;
  final bool postsEnd;

  const UpdatePosts({@required this.posts, this.postsEnd = true});

  @override
  List<Object> get props => [posts, postsEnd];

  @override
  String toString() {
    return 'UpdatePosts{posts: $posts, postsEnd: $postsEnd}';
  }
}

class DeletePost extends PostEvent {
  final Post post;

  const DeletePost({@required this.post});

  @override
  List<Object> get props => [post];

  @override
  String toString() {
    return 'DeletePost{post: $post }';
  }
}

class AddPost extends PostEvent {
  final Post post;
  final Uint8List image;
  final String extenstion;

  const AddPost(
      {@required this.post, @required this.image, @required this.extenstion});

  @override
  List<Object> get props => [post, image, extenstion];

  @override
  String toString() =>
      'AddPost { post: $post, image: $image, extenstion: $extenstion }';
}

class FilterChanged extends PostEvent {
  final String filter;

  const FilterChanged({@required this.filter});

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterChanged { filter: $filter }';
}
