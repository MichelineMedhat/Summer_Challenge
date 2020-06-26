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
  @override
  String toString() {
    return 'LoadPosts';
  }
}

class UpdatePosts extends PostEvent {
  final List<Post> posts;

  const UpdatePosts({@required this.posts});

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'UpdatePosts { posts: $posts }';
}

class AddPost extends PostEvent {
  final Post post;
  final Uint8List image;
  final String extenstion;

  const AddPost({@required this.post, @required this.image, @required this.extenstion});

  @override
  List<Object> get props => [post, image, extenstion];

  @override
  String toString() => 'AddPost { post: $post, image: $image, extenstion: $extenstion }';
}
