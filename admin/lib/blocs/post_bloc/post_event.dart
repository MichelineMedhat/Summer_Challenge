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

class AddScore extends PostEvent {
  final String username;
  final double score;
  final Post post;
  const AddScore({@required this.username, @required this.score, @required this.post});

  @override
  List<Object> get props => [username, score, post];

  @override
  String toString() => 'AddScore { username: $username, score: $score, post: $post}';
}

class ScoreChanged extends PostEvent {
  final double score;
  const ScoreChanged({@required this.score});

  @override
  List<Object> get props => [score];

  @override
  String toString() => 'AddScore {score: $score }';
}
