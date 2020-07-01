import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';
import '../models/user.dart';

class PostRepository {
  static final Firestore _db = Firestore.instance;

 static Stream<List<Post>> getAllPosts() {
    return _db
        .collection('posts')
        .where('graded', isEqualTo: '0')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => Post.fromDocument(doc)).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  static Future<void> addScore(String username, double score, Post post) async {
    var doc = await _db.collection('users').document(username).get();
    User user = User.fromDocument(doc);
    user.score += score;
    post.graded = '1';
    await _db.collection('users').document(username).updateData(user.toMap());
    await _db.collection('posts').document(post.id).updateData(post.toMap());
  }

  static Stream<List<Post>> getUsersFilter(String username) {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.username == username)
          .toList();
    });
  }

  static Stream<List<Post>> getHashtagsFilter(String hashtag) {
    return _db.collection('posts').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Post.fromDocument(doc))
          .where((element) => element.hashtag == hashtag)
          .toList();
    });
  }
}
